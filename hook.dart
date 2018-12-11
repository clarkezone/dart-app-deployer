library github_deploying_app;

import 'appconfig.dart';
import 'application.dart';
import 'environment_checker.dart';
import 'github_hook_listener.dart';
import 'project_deployer.dart';

main() async {
  Appconfig configLoader = new Appconfig("config.yaml");
  EnvironmentChecker environmentChecker = new EnvironmentChecker();

  assert(environmentChecker.githubToken != null);

  ProjectDeployer deployer = new ProjectDeployer();
  GithubHookListener hookListener = new GithubHookListener(environmentChecker, configLoader, deployer);

  Application app = new Application(hookListener);

  app.run();
}
