import 'dart:convert';

import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../arch_gen.dart';

@immutable
class ImplementedOn {
  const ImplementedOn(this.environment);

  final Object Function() environment;
}

class ImplementedOnGenerator extends Generator {
  static Map<DartType, List<DartType>> environmentAttributes = {};

  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    final Map<String, Object?> implementedOn = {};
    const typeChecker = TypeChecker.fromRuntime(ImplementedOn);

    for (final c in library.classes) {
      if (typeChecker.hasAnnotationOfExact(c)) {
        for (final annotation in typeChecker.annotationsOfExact(c)) {
          final envNameParts = annotation.getField("environment")!.toFunctionValue()!.displayName.split(".");
          final part2 = envNameParts[1];
          final envName = envNameParts[0] + part2.substring(0, 1).toUpperCase() + part2.substring(1);
          final types = List<InterfaceType>.from(c.allSupertypes);

          types.add(c.thisType);

          implementedOn[envName] = {
            "concrete": c.displayName,
            "interfaces": types
                .map((i) => {
                      "type": i.getDisplayString(withNullability: false),
                      "parameters": i.constructors.first.parameters
                          .map(
                            (p) => {
                              "name": p.displayName,
                              "type": p.type.getDisplayString(withNullability: false),
                            },
                          )
                          .toList(),
                    })
                .toList(),
          };
        }
      }
    }

    if (implementedOn.isEmpty) {
      return null;
    }

    return jsonEncode(implementedOn);
  }
}
