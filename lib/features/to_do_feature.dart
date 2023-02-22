import '../arch_gen/arch_gen.dart';
import '../env.dart';

import 'contracts/i_to_do_repository.dart';

@Uses({
  Env.production: [
    IToDoRepository,
  ],
  Env.development: [
    IToDoRepository,
  ],
  Env.test: [
    IToDoRepository,
  ],
})
abstract class $ToDoFeature extends Feature {}
