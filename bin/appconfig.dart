import 'package:safe_config/safe_config.dart';
import 'dart:io';

class Appconfig extends Configuration {
	Appconfig(File file) : 
		super.fromFile(file);

	int listeningPort;
	String gitWorkingDir;
	String gitTarget;
	String clientHostname;
	String githubToken;
}
