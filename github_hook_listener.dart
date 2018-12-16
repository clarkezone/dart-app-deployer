library github_hook_listener;

import 'dart:io';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'environment_checker.dart';
import 'project_deployer.dart';
import 'appconfig.dart';

class GithubHookListener {
  EnvironmentChecker environmentChecker;
  Appconfig config;
  ProjectDeployer deployer;
  String targetBranch;

  GithubHookListener(this.environmentChecker, this.config, this.deployer) {
    targetBranch = config.gitTarget;
  }

  bool xHubSignatureFitsOurs(String signature, data) {
    var sha = new Hmac(sha1, utf8.encode(config.githubToken));
    var digest = sha.convert(data);
    var hash = hex.encode(digest.bytes);
    return signature == "sha1=$hash";
  }

  bool wasPushOnMaster(String ref) => ref == 'refs/heads/$targetBranch';

  listen() async {
    HttpServer server = await HttpServer.bind(config.clientHostname, config.listeningPort);
    print('listening on localhost, port ${server.port}');

    server.listen((HttpRequest request) {
      request.listen((data) {
        if (xHubSignatureFitsOurs(request.headers.value("x-hub-signature"), data)) {
          request.response.close();
        }
	else {
		print("signature doesn't match");
		return;
	}
        var payl = new String.fromCharCodes(data);
        var payload = json.decode(payl);
        print(payload['ref']);
        if (wasPushOnMaster(payload['ref'])) {
          print("Hooked on push on $targetBranch");
          deployer.resetAndPullBranch()
          //.then((_) => deployer.upgradeServerDependencies())
          //.then((_) => deployer.startServer())
          //.then((_) => deployer.deployClient());
        }
      });
    });
    //deployer.killServerProcess();
  }
}
