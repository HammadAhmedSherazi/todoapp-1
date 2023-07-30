import 'package:todoapp/providers/todo_provider.dart';

import '../export_all.dart';

Widget todoConsumerWidget(BuildContext context, WidgetRef ref) {
  final config = ref.watch(todoProvider);

  return config.when(
    

    loading: () => const CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
    data: (config) {
      return ListView.separated(
        padding: EdgeInsets.only(top: 10.r, right: 10.r, left: 10.r, bottom: 50.r),
        itemBuilder: (context, index) => TodoWidget(item: config[config.length -1 - index ],), separatorBuilder: (context, index) => 10.verticalSpace, itemCount: config.length);
    },
  );
}