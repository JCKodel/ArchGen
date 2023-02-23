import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../arch_gen.dart';

@immutable
class Entity {
  const Entity();
}

class EntityGenerator extends GeneratorForAnnotation<Entity> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElement = element as ClassElement;
    var generateEquatable = false;
    var generateCopyWith = false;
    var generateSerialization = false;

    for (final interface in classElement.interfaces) {
      if (interface.element.name == "IEquatable") {
        generateEquatable = true;
      } else if (interface.element.name == "ICopyable") {
        generateCopyWith = true;
      } else if (interface.element.name == "ISerializable") {
        generateSerialization = true;
      }
    }

    final className = classElement.name.substring(1);
    final output = <String>[];

    output.add("@immutable");

    output.add(
      "class ${className} implements ${element.name} "
      "${generateEquatable ? ", IEquatable" : ""}"
      "${generateCopyWith ? ", ICopyable" : ""}"
      "${generateSerialization ? ", ISerializable" : ""}"
      "{",
    );

    if (classElement.constructors.length != 1) {
      throw "The data class must have one and only constructor with all required fields "
          "(ex.: const factory IYourClass({int id, String name})) = _YourClass";
    }

    if (classElement.constructors[0].isConst == false || classElement.constructors[0].isFactory == false) {
      throw "The data class must have a const factory constructor";
    }

    final constructor = classElement.constructors[0];

    output.add("const ${className}({");

    for (final field in constructor.parameters) {
      output.add("${field.type.nullabilitySuffix == NullabilitySuffix.none ? "required " : ""}this.${field.displayName},");
    }

    output.add("});\n");

    for (final field in constructor.parameters) {
      output.add("final ${field.type} ${field.name};");
    }

    output.add("");
    output.add("@override");
    output.add("String toString() {");
    output.add("return '${element.name}(\\n'");

    final parameters = constructor.parameters;

    parameters.sort((a, b) => a.name.compareTo(b.name));

    for (final field in parameters) {
      output.add("'  ${field.name}: \${${field.name}}\\n'");
    }

    output.add("')';");
    output.add("}");

    if (generateEquatable) {
      _generateEquatable(output, constructor.parameters, className);
    }

    if (generateCopyWith) {
      _generateCopyWith(output, constructor.parameters, className);
    }

    if (generateSerialization) {
      _generateSerialization(output, constructor.parameters, className, buildStep);
    }

    output.add("}");

    return output.join("\n");
  }

  void _generateEquatable(List<String> output, List<ParameterElement> parameters, String className) {
    output.add("");
    output.add("@override");
    output.add("bool operator ==(Object other) {");
    output.add("if(other is ${className} == false) {");
    output.add("return false;");
    output.add("}");
    output.add("");
    output.add("final o = other as ${className};");
    output.add("");
    output.add("return other.runtimeType == runtimeType");

    for (final field in parameters) {
      output.add("&& o.${field.name} == ${field.name}");
    }

    output.add(";");
    output.add("}\n");
    output.add("@override");
    output.add("int get hashCode {");
    output.add("return Object.hash(");
    output.add("runtimeType,");

    for (final field in parameters) {
      output.add("${field.name},");
    }

    output.add(");");
    output.add("}");
  }

  void _generateCopyWith(List<String> output, List<ParameterElement> parameters, String className) {
    output.add("");
    output.add("${className} copyWith({");

    for (final field in parameters) {
      output.add("${field.type}${field.type.nullabilitySuffix == NullabilitySuffix.none ? "?" : ""} ${field.name},");
    }

    output.add("}) {");
    output.add("return ${className}(");

    for (final field in parameters) {
      output.add("${field.name}: ${field.name} ?? this.${field.name},");
    }

    output.add(");");
    output.add("}");
  }

  void _generateSerialization(List<String> output, List<ParameterElement> parameters, String className, BuildStep buildStep) {
    output.add("");
    output.add("factory ${className}.fromMap(Map<String, Object?> map) {");
    output.add("return ${className}(");

    for (final field in parameters) {
      if (field.type.element!.name == "DateTime") {
        if (field.type.nullabilitySuffix == NullabilitySuffix.question) {
          output.add("${field.name}: map['${field.name}'] == null ? null : DateTime.parse(map['${field.name}'] as String).toLocal(),");
        } else {
          output.add("${field.name}: DateTime.parse(map['${field.name}'] as String).toLocal(),");
        }
      } else if (field.type.element is EnumElement) {
        if (field.type.nullabilitySuffix == NullabilitySuffix.question) {
          output.add("${field.name}: map['${field.name}'] == null ? null : ${_buildEnumToMap(field)},");
        } else {
          output.add("${field.name}: ${_buildEnumToMap(field)}");
        }
      } else if (field.type.element is ClassElement) {
        final ce = field.type.element as ClassElement;

        if (ce.interfaces.any((i) => i.element.name == "ISerializable")) {
          if (field.type.nullabilitySuffix == NullabilitySuffix.question) {
            output.add("${field.name}: map['${field.name}'] == null ? null : ${className}.fromMap(map['${field.name}'] as Map<String, Object?>),");
          } else {
            output.add("${field.name}: ${className}.fromMap(map['${field.name}']),");
          }
        } else {
          output.add("${field.name}: map['${field.name}'] as ${field.type},");
        }
      } else {
        output.add("${field.name}: map['${field.name}'] as ${field.type},");
      }
    }

    output.add(");");
    output.add("}");
    output.add("");
    output.add("Map<String, Object?> toMap() {");
    output.add("return <String, Object?> {");

    for (final field in parameters) {
      final nullable = field.type.nullabilitySuffix == NullabilitySuffix.question ? "?" : "";

      if (field.type.element!.name == "DateTime") {
        output.add("'${field.name}': ${field.name}${nullable}.toUtc().toIso8601String(),");
      } else if (field.type.element is EnumElement) {
        output.add("'${field.name}': ${field.name}${nullable}.toString().substring(${field.type.element!.name!.length + 1}),");
      } else if (field.type.element is ClassElement) {
        final ce = field.type.element as ClassElement;

        if (ce.interfaces.any((i) => i.element.name == "ISerializable")) {
          output.add("'${field.name}': ${field.name}${nullable}.toMap(),");
        } else {
          output.add("'${field.name}': ${field.name},");
        }
      } else {
        output.add("'${field.name}': ${field.name},");
      }
    }

    output.add("};");
    output.add("}");
  }

  String _buildEnumToMap(ParameterElement field) {
    final enumElement = field.type.element as EnumElement;
    final output = <String>[];

    output.add("{");

    for (final child in enumElement.fields) {
      if (child.type.element!.name == field.type.element!.name) {
        output.add("'${child.displayName}': ${child.type}.${child.displayName},");
      }
    }

    output.add("}[map['${field.name}'] as String] as ${field.type}");

    return output.join();
  }
}
