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

  ProjectDeployer(this.config) {
    gitTarget = config.gitTarget;
    gitWorkingDir = config.gitWorkingDir;
  }

  Future resetAndPullBranch() {
    print("Resetting branch");
    print("WorkingDir:$gitWorkingDir");
    return Process.run("bash", ["-c", "git pull origin/$gitTarget"], workingDirectory: gitWorkingDir)
    .then((Process) => showLogsForProcessResult(Process));
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
