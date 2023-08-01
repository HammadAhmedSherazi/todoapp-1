
import '../export_all.dart';

class TodoListNotifier extends StateNotifier<List<TodoModule>> {
  TodoListNotifier() : super([]);

  void listAdd(List<TodoModule> lst){
    // state = [];
    state = [...state,...lst];
  }

  void addTodo(TodoModule item) {
    state = [...state,item];
  }

  void deleteTodo(int index) {
    state = List.from(state)..removeAt(index);
  }

  void toggleTodoStatus(int index) {
    // state[index].isCheck = !state[index].isCheck!;
    state = List.from(state)
      ..[index] = TodoModule(
        title: state[index].title,
        desc: state[index].desc,
        isCheck: !state[index].isCheck!,
        iV: state[index].iV!,
        sId: state[index].sId,
        userId: state[index].userId
      );

      
  }

  void updateTodoItem(int index, TodoModule item){
    state =List.from(state)..[index] = item;
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<TodoModule>>(
  (ref) => TodoListNotifier(),
);