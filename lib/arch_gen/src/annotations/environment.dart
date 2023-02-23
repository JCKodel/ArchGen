import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import '../../arch_gen.dart';

@immutable
class Environment {
  const Environment();
}

class EnvironmentGenerator extends GeneratorForAnnotation<Environment> {
  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final output = <String>[];
    final classElement = element as ClassElement;

    for (final constructor in classElement.constructors) {
      if (constructor.isConst && constructor.isFactory) {
        await _generateEnvironment(output, classElement, constructor, buildStep);
        output.add("");
      }
    }

    return output.join("\n");
  }

  Future<void> _generateEnvironment(List<String> output, ClassElement classElement, ConstructorElement constructor, BuildStep buildStep) async {
    final classNameParts = constructor.displayName.split(".");
    final part2 = classNameParts[1];
    final className = classNameParts[0] + part2.substring(0, 1).toUpperCase() + part2.substring(1);

    output.add("@immutable");
    output.add("class ${className} implements Env {");
    output.add("const ${className}();");
    final useThisConcreteOn = Glob("**.use_this_concrete_on.json");

    await for (final id in buildStep.findAssets(useThisConcreteOn)) {
      output.add("");

      final useThisConcreteOn = jsonDecode(await buildStep.readAsString(id)) as Map<String, dynamic>;
      final entry = useThisConcreteOn[className];

      if (entry != null) {
        final concrete = entry["concrete"] as String;
        final interfaces = entry["interfaces"] as List<dynamic>;

        for (final property in classElement.fields) {
          final propType = property.type.getDisplayString(withNullability: false);
          final interface = interfaces.firstWhere((i) => i["type"] == propType, orElse: () => null);

          if (interface != null) {
            final parameters = interface["parameters"] as List<dynamic>;

            if (parameters.isEmpty) {
              output.add("${interface["type"]} get ${property.displayName} => ${concrete}();");
            } else {
              final concretes = Map.fromEntries(
                classElement.fields.map(
                  (c) => MapEntry<String, String>(
                    c.type.getDisplayString(withNullability: false),
                    c.displayName,
                  ),
                ),
              );

              output.add(
                "${interface["type"]} get ${property.displayName} => ${concrete}("
                "${parameters.map((p) => "${p["name"]}: ${concretes[p["type"]]}").join(", ")}"
                ");",
              );
            }
          }
        }
      }
    }

    output.add("}");
  }
}
