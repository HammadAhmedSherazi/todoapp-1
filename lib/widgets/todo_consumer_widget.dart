import '../export_all.dart';

Widget todoConsumerWidget(BuildContext context, WidgetRef ref) {
  final config = ref.watch(todoProvider);
  // final todo = ref.read(todoListProvider);
  return config.when(
    
    
    loading: () => const  Center(child:  CircularProgressIndicator(
      color: Color.fromARGB(209, 119, 51, 48),
    )),
    error: (err, stack) => Center(child: Text('$err')),
    data: (config) {
      
        Future.delayed(Duration.zero, (){
          
            ref.read(todoListProvider.notifier).listAdd(List.generate(config.length, (index) => config[index]));
              
        });
      
      final todoList = ref.watch(todoListProvider); 
      return ListView.separated(
        padding: EdgeInsets.only(top: 10.r, right: 10.r, left: 10.r, bottom: 50.r),
        itemBuilder: (context, index) => TodoWidget(item: todoList[todoList.length -1 - index ],), separatorBuilder: (context, index) => 10.verticalSpace, itemCount: todoList.length);
    },
  );
}