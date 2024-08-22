import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'storage_item.dart';

class StorageProvider with ChangeNotifier {
  final FirebaseStorage storage = FirebaseStorage.instance;
  List<StorageItem> _items = [];
  List<StorageItem> get items => _items;

  Future<void> fetchItems(String path) async {
    _items = [];
    final ListResult result = await storage.ref(path).listAll();
    for (var prefix in result.prefixes) {
      _items.add(StorageItem(
          name: prefix.name, isFolder: true, path: prefix.fullPath));
    }
    for (var file in result.items) {
      _items.add(
          StorageItem(name: file.name, isFolder: false, path: file.fullPath));
    }
    notifyListeners();
  }
}
