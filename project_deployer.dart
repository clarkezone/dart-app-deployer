import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'appconfig.dart';

class ProjectDeployer {
  Appconfig config;
  var clientPath;
  var gitTarget;
  var gitWorkingDir;
  var serverFileName;
  var serverPath;
  var websitePath;
  Process serverProcess;

  ProjectDeployer() {
    //gitTarget = config["gitTarget"];
    //gitWorkingDir = config["gitWorkingDir"];
  }

  Future resetAndPullBranch() {
    print("Resetting branch");
    return Process.run("bash", ["-c", "git pull && git reset --hard origin/$gitTarget"], workingDirectory: gitWorkingDir)
    .then((process) => showLogsForProcessResult(process));
  }

  void showLogs(Process process) {
    process.stdout.transform(utf8.decoder).listen((data) => print(data));
    process.stderr.transform(utf8.decoder).listen((data) => print(data));
  }

  void showLogsForProcessResult(ProcessResult processResult) {
    print(processResult.stderr);
    print(processResult.stdout);
  }
}
