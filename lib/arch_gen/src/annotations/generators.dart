import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../arch_gen.dart';

Builder dataClassBuilder(BuilderOptions options) => SharedPartBuilder(
      [DataClassGenerator()],
      "data_class",
    );

Builder environmentBuilder(BuilderOptions options) => SharedPartBuilder(
      [EnvironmentGenerator()],
      "environment",
    );

Builder implementedOnBuilder(BuilderOptions options) => LibraryBuilder(
      ImplementedOnGenerator(),
      generatedExtension: ".implemented_on.json",
      formatOutput: (generated) => generated.replaceAll(RegExp(r"//.*|\s"), ""),
    );
