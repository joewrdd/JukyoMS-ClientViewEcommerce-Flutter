import 'package:get_storage/get_storage.dart';

class LocalStorage {
  //----- Initialize Singleton Instance -----
  late final GetStorage _storage;

  //---- Singleton Instance -----
  static LocalStorage? _instance;

  //----- Singleton Instance Setter -----
  LocalStorage._internal();

  //----- Singleton Instance Getter -----
  factory LocalStorage.instance() {
    _instance ??= LocalStorage._internal();
    return _instance!;
  }

  //----- Initialize Storage -----
  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = LocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  //----- Generic Method To Save Data -----
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  //----- Generic Method To Read Data -----
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  //----- Generic Method To Remove Data -----
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  //----- Clear All Data In Storage -----
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
