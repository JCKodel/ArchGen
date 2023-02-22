import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../../arch_gen.dart';

Builder dataClassBuilder(BuilderOptions options) => SharedPartBuilder([DataClassGenerator()], 'data_class');
