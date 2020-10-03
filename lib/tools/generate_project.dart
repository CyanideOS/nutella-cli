import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:json2yaml/json2yaml.dart';

void newProject(String path) {
  Directory(path).create(recursive: true);
}

class GenerateCommand extends Command {
  @override
  String get name => 'generate';
  @override
  String get description => 'Generates Nutella Project';

  String projectName;
  String projectDirectory;

  GenerateCommand() {
    argParser.addOption('template');
  }

  void generateAssets() {
    Directory('$projectDirectory/Assets').createSync(recursive: true);
  }

  void generatePages() {
    /// Generate Pages directory
    Directory('$projectDirectory/Pages').createSync(recursive: true);
    Directory.current = '$projectDirectory/Pages';

    /// Generate Default page
    File('${Directory.current.path}/Main.page.dart').createSync();

    /// Change the directory back
    Directory.current = projectDirectory;
  }

  void generateServices() {
    Directory('$projectDirectory/Services').createSync(recursive: true);
  }

  void generateApplicationManifest() {
    final applicationManifestData = {
      'name': '"$projectName"',
      'description': '"An Amazing Project"',
      'icon': '"./Assets/icon.ico"',
    };

    final applicationManifest = File('$projectDirectory/Application.yaml');
    applicationManifest.createSync();
    applicationManifest.writeAsStringSync(json2yaml(applicationManifestData));
  }

  @override
  void run() {
    if (argResults.rest.isEmpty) {
      print('[Warning] Please pass the project name! Got empty');
      return;
    }

    projectName = argResults.rest[0];
    projectDirectory = '${Directory.current.path}/${argResults.rest[0]}';

    Directory(projectDirectory).createSync(recursive: true);
    Directory.current = projectDirectory;

    generateAssets();
    generatePages();
    generateServices();
    generateApplicationManifest();
  }
}
