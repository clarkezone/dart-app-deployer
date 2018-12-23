library application;

import 'github_hook_listener.dart';
import 'dart:async';

class Application {
  GithubHookListener hookListener;

  Application(this.hookListener);

  void run() {
    runZoned(() {
    hookListener.listen();},
     onError:(e, stackTrace){}
    );  
  } //run
}
