import 'dart:developer';
import 'dart:io';

import 'package:todoapp/export_all.dart';
import 'package:todoapp/providers/todo_provider.dart';
import 'package:todoapp/widgets/todo_consumer_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

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
            floatingActionButton: Consumer(
              builder: (context, ref, child) {
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
              }
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // fluter 1.x
            resizeToAvoidBottomInset: false,
            body: Consumer(
              builder: (context, ref, child) =>
                  todoConsumerWidget(context, ref),
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
                              "desc": descTextController.text
                            };
                            await ApiService.addTodoApi(sendData, context);
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
