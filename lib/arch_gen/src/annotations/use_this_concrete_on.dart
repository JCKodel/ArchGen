import 'dart:convert';

import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../arch_gen.dart';

@immutable
class UseThisConcreteOn {
  const UseThisConcreteOn(this.environmentImplementationClassName);

  final String environmentImplementationClassName;
}

class UseThisConcreteOnGenerator extends Generator {
  static Map<DartType, List<DartType>> environmentAttributes = {};

  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    final Map<String, Object?> useThisConcreteOn = {};
    const typeChecker = TypeChecker.fromRuntime(UseThisConcreteOn);

    for (final c in library.classes) {
      if (typeChecker.hasAnnotationOfExact(c)) {
        for (final annotation in typeChecker.annotationsOfExact(c)) {
          final envName = annotation.getField("environmentImplementationClassName")!.toStringValue()!;
          final types = List<InterfaceType>.from(c.allSupertypes);

          types.add(c.thisType);

          useThisConcreteOn[envName] = {
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

    if (useThisConcreteOn.isEmpty) {
      return null;
    }

    return jsonEncode(useThisConcreteOn);
  }
}
