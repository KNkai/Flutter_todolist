import 'package:todolist_sqflite/src/Models/todo_model.dart';
import 'package:todolist_sqflite/src/repository/todo_repository.dart';

class TodoService {
  TodoRepository _todoRepository;

  TodoService() {
    _todoRepository = TodoRepository();
  }

  saveTodo(Todo todo) async {
    return await _todoRepository.save('todo', todo.todoMap());
  }

  getAllTodo(int id) async {
    return await _todoRepository.getAllTodo('todo', id);
  }

  deleteTodoById(int id) async {
    return await _todoRepository.deleteTodoByid('todo', id);
  }

  deleteTodoByIdCate(int id) async {
    return await _todoRepository.deleteTodoByIdCate('todo', id);
  }

  updateTodo(Todo todo) async {
    return await _todoRepository.updateTodo('todo', todo.todoMap(), todo.id);
  }

  getATodo(int id) async {
    return await _todoRepository.getATodo('todo', id);
  }
}
