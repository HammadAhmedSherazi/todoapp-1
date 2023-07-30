
import 'package:flutter_slidable/flutter_slidable.dart';

import '../export_all.dart';

class TodoWidget extends StatelessWidget {
   final TodoModule ? item;
   const TodoWidget({
    super.key,
    this.item
  });

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
              onPressed: (context) {},
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
                onPressed: () {},
                icon: const Icon(
                    Icons.check_box_outline_blank)),
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
              // item!.desc!,
              "",
              // "Todo Description",
              style: TextStyle(
                  fontSize: 10.sp, color: Colors.black),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: 18.r,
                )),
          ),
        ));
  }
}
