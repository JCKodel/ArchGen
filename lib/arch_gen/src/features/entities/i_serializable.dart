import '../../../arch_gen.dart';

@immutable
abstract class ISerializable {
  Map<String, Object?> toMap();
}
