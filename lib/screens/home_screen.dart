import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:todoapp/export_all.dart';

import 'package:todoapp/widgets/todo_consumer_widget.dart';

import '../providers/todo_get_provider.dart';
import '../providers/todo_state_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleTextController = TextEditingController();

  TextEditingController descTextController = TextEditingController();
  // List todoItemList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration.zero, ()async{
    // todoItemList.clear();
    //  todoItemList = await ApiService().getTodoList();

    //  setState(() {
    //  isLoading = true;
    //  });
    // });
  }

  @override
  void dispose() {
    titleTextController.dispose();
    descTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // image: DecorationImage(
          //     image: NetworkImage(
          //       "https://thumbs.dreamstime.com/b/todo-list-seamless-pattern-universal-background-66678083.jpg",
          //     ),
          //     fit: BoxFit.fill)8
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color(0xffF64F59),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(25.r))),
              centerTitle: true,
              title: Text(
                'Todo',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18.sp),
              ),
            ),
            bottomNavigationBar: const BottomAppBar(
              shape: CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              height: 60.0,
              color: Color(0xffF64F59),
            ),
            floatingActionButton: Consumer(builder: (context, ref, child) {
              return FloatingActionButton(
                heroTag: 'MainButton',
                onPressed: () {
                  addTodoDailog(context, ref);
                },
                backgroundColor: const Color.fromARGB(209, 119, 51, 48),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              );
            }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // fluter 1.x
            resizeToAvoidBottomInset: false,
            body: Consumer(
              builder: (context, ref, child) {
                final config = ref.watch(todoProvider);
                // final todo = ref.read(todoListProvider);
                return config.when(
                  loading: () => const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromARGB(209, 119, 51, 48),
                  )),
                  error: (err, stack) => Center(child: Text('$err')),
                  data: (config) {
                    if (isLoading) {
                      Future.delayed(Duration.zero, () {
                        ref.read(todoListProvider.notifier).listAdd(
                            List.generate(
                                config.length, (index) => config[index]));
                    isLoading = false;

                      });
                    }
                    final todoList = ref.watch(todoListProvider);
                    return  todoList.isEmpty && isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Color.fromARGB(209, 119, 51, 48),
                          ))
                        : todoList.isNotEmpty? ListView.separated(
                            padding: EdgeInsets.only(
                                top: 10.r,
                                right: 10.r,
                                left: 10.r,
                                bottom: 50.r),
                            itemBuilder: (context, index) => TodoWidget(
                                  item: todoList[todoList.length - 1 - index],
                                  index: todoList.length - 1 - index,
                                  ref:  ref,
                                ),
                            separatorBuilder: (context, index) =>
                                10.verticalSpace,
                            itemCount: todoList.length) : const Center(
                              child: Text("Add todos to get started!", style: TextStyle(
                                color: Colors.black
                              ),),
                            );
                  },
                );
              },
            )

            // !isLoading && todoItemList.isEmpty ? const Center(
            //   child: CircularProgressIndicator(
            //     color: Color.fromARGB(209, 119, 51, 48),
            //   )
            // ): todoItemList.isNotEmpty ? ListView.separated(shrinkWrap: true,itemBuilder: (context, index) => TodoWidget(item: todoItemList[index],), separatorBuilder: (context, index) => 10.verticalSpace, itemCount: todoItemList.length)
            // : const Center(
            //   child: Text("Todo is not exist yet!"),
            // )
            ));
  }

  Future<dynamic> addTodoDailog(BuildContext context, WidgetRef ref) {
    return showDialog(
        context: context,

        // user must tap button!
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.all(20.r),
              margin: EdgeInsets.symmetric(horizontal: 30.r, vertical: 180.r),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // 30.verticalSpace,
                children: [
                  Text(
                    'Add Todo',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  TextWidget(
                    controller: titleTextController,
                    fillColor: const Color.fromARGB(255, 238, 222, 227),
                    hintText: "Title",
                  ),
                  TextWidget(
                    controller: descTextController,
                    fillColor: const Color.fromARGB(255, 238, 222, 227),
                    hintText: "Description...",
                    maxlines: 5,
                  ),
                  Platform.isAndroid
                      ? ButtonWidgetAndroid(
                          buttonText: "Add".toUpperCase(),
                          width: 362.w,
                          onTap: () async {
                            Map<String, String> sendData = {
                              "userId": userId,
                              "title": titleTextController.text,
                              "desc": descTextController.text,
                              
                            };
                            await ApiService.addTodoApi(sendData, context)
                                .then((vale) {
                              if (vale != null) {
                                ref
                                    .read(todoListProvider.notifier)
                                    .addTodo(vale);
                              }
                            });
                            // ref.watch(todoProvider).whenData((value) => null);
                            titleTextController.text = "";
                            descTextController.text = "";
                          },
                        )
                      : ButtonWidgetIOS(
                          buttonText: "Add".toUpperCase(),
                          width: 362.w,
                          onTap: () async {
                            Map<String, String> sendData = {
                              "userId": userId,
                              "title": titleTextController.text,
                              "desc": descTextController.text
                            };
                            await ApiService.addTodoApi(sendData, context);
                            titleTextController.text = "";
                            descTextController.text = "";
                          },
                        )
                ],
              ),
            ),
          );
        });
  }
}
