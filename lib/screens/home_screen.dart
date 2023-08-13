import 'dart:async';
import 'dart:io';

import 'package:todoapp/export_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
            drawer: drawer(),
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.person_2_rounded),
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
              ),
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
                    return todoList.isEmpty && isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Color.fromARGB(209, 119, 51, 48),
                          ))
                        : todoList.isNotEmpty
                            ? ListView.separated(
                                padding: EdgeInsets.only(
                                    top: 10.r,
                                    right: 10.r,
                                    left: 10.r,
                                    bottom: 50.r),
                                itemBuilder: (context, index) => TodoWidget(
                                      item:
                                          todoList[todoList.length - 1 - index],
                                      index: todoList.length - 1 - index,
                                      ref: ref,
                                    ),
                                separatorBuilder: (context, index) =>
                                    10.verticalSpace,
                                itemCount: todoList.length)
                            : const Center(
                                child: Text(
                                  "Add todos to get started!",
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                  },
                );
              },
            )));
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

  Drawer drawer() {
    return Drawer(
      clipBehavior: Clip.none,
      width: 260.w,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.r),
              bottomRight: Radius.circular(50.r))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawerHeader(

              curve: Curves.linear,
              child: Column(
                children: [
                  // 20.horizontalSpace,
                  CircleAvatar(
                    radius: 42.r,
                    backgroundImage: const NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0m5Cy4lXCbuyG54L0vuo3i5-ALavHe9KmhWA_wDM&s',
                    ),
                  ),
                  50.horizontalSpace,
                  Text(
                    Data.userDetail!.name!,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp),
                  )
                ],
              )),
          10.verticalSpace,
          ListTile(
            onTap: () => Navigator.of(context).pop(),
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
            ),
          ),
          const Spacer(),
          ListTile(
            onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/LoginScreen', (Route<dynamic> route) => false),
            leading: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.red,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
            ),
          ),
          80.verticalSpace
        ],
      ),
    );
  }
}
