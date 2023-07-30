
import 'package:todoapp/export_all.dart';




final todoProvider = FutureProvider<List>((ref) => ref.watch(apiServiceProvider).getTodoList());


// final resultListProvider = FutureProvider((ref) async {
//   return ref.watch(apiServiceProvider).getTodoList();
// });



