import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../domain/todo_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  //koneksi ke database
  Future<Isar> openDB() async {
    // Jika sudah pernah dibuka, pakai yang sudah ada
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory(); // Cari folder HP
      return await Isar.open(
        [TodoSchema], // Masukkan skema yang dihasilkan Build Runner
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  //create
  Future<void> saveTodo(Todo newTodo) async {
    final isar = await db;
    // Transaksi sinkron (writeTxnSync) untuk operasi tulis data
    isar.writeTxnSync<int>(() => isar.todos.putSync(newTodo));
  }

  //update
  Future<void> updateTodoStatus(Id id, bool isCompleted) async {
    final isar = await db;
    final todo = await isar.todos.get(id); // Cari datanya dulu
    if (todo != null) {
      todo.isCompleted = isCompleted;
      isar.writeTxnSync(() => isar.todos.putSync(todo)); // Timpa datanya
    }
  }

  //delete
  Future<void> deleteTodo(Id id) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.todos.deleteSync(id));
  }

  //read dan reactive
  Stream<List<Todo>> listenToTodos() async* {
    final isar = await db;
    // watch(fireImmediately: true) artinya pancarkan data saat ini juga,
    // lalu pantau terus perubahannya ke depan!
    yield* isar.todos.where().watch(fireImmediately: true);
  }
}
