library github_deploying_app;

import 'appconfig.dart';
import 'application.dart';
import 'environment_checker.dart';
import 'github_hook_listener.dart';
import 'project_deployer.dart';
import 'dart:io';

main() async {
  File file = new File("/app/bin/config.yaml");
  Appconfig configLoader = new Appconfig(file);
  EnvironmentChecker environmentChecker = new EnvironmentChecker();

  assert(environmentChecker.githubToken != null);

  ProjectDeployer deployer = new ProjectDeployer(configLoader);

  GithubHookListener hookListener = new GithubHookListener(environmentChecker, configLoader, deployer);

    //deployer.resetAndPullBranch();
    //return;
  Application app = new Application(hookListener);

  app.run();
}
