import 'package:args/command_runner.dart';
import 'package:cli/tools/generate_project.dart';

int main(List<String> args) {
  final runner =
      CommandRunner('nutella', 'CLI Toolkit for Nutella Dektop Applications.')
        ..addCommand(GenerateCommand());

  runner.run(args);
  return 0;
}
