

// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter_slidable/flutter_slidable.dart';
import '../export_all.dart';

class TodoWidget extends StatelessWidget {
   final TodoModule ? item;
    WidgetRef ? ref;
    final int ? index;
    TodoWidget({
    super.key,
    this.item,
    this.ref,
    this.index
  });

  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          // A pane can dismiss the Slidable.
          // dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context)  {
                // print(item!.sId);
    //              showDialog(
    //   context: context,
    //   builder: (context) => WillPopScope(
    //     child: spinkit,
    //     onWillPop: () async {
    //       return false;
    //     },
    //   ),
    // );        

              ApiService.deteteTodoApi(item!.sId!, context).then((value) {
                if(value){
                  ref?.read(todoListProvider.notifier).deleteTodo(index!);
                  
                }
      // Navigator.popUntil(context, (route) => false);

                
              });
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.red,
              icon: Icons.delete,
              flex: 3,
              label: 'Delete',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Card(
          clipBehavior: Clip.none,
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r)),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: IconButton(
                onPressed: () async{
                      // print(item!.toJson());
                      // print(jsonEncode(item!.toJson()));
                  ref?.read(todoListProvider.notifier).toggleTodoStatus(index!);                  
                    log(item.toString());
                    item!.isCheck = !(item!.isCheck!); 
                    ApiService.updateTodo(item!.toJson());
                  },
                icon: !item!.isCheck! ? const Icon(
                    Icons.check_box_outline_blank) : const Icon(Icons.check_box, color: Color.fromARGB(209, 119, 51, 48),)),
            title: Text(
              item!.title!,
              // "Todo Title",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text( 
              item!.desc!,
              
              // "Todo Description",
              style: TextStyle(
                  fontSize: 10.sp, color: Colors.black),
            ),
            trailing: IconButton(
                onPressed: () {

                  editTodoDialog(context, ref!, item!, index!);
                },
                icon: Icon(
                  Icons.edit,
                  size: 18.r,
                )),
          ),
        ));
  }

  Future<dynamic> editTodoDialog(BuildContext context, WidgetRef ref, TodoModule todo, int index){
    titleTextController.text = todo.title!;
    descTextController.text = todo.desc!;
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
                    'Edit Todo',
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
                            todo.title = titleTextController.text;
                            todo.desc = descTextController.text;

                            await ApiService.updateTodo(todo.toJson())
                                .then((val) {
                              if (val != null ) {
                                
                                ref
                                    .read(todoListProvider.notifier)
                                    .updateTodoItem(index,val);
                              }
                            });
                            
                            Navigator.of(context).pop();
;
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
