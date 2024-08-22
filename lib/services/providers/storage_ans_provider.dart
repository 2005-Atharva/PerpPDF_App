import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:user_auth_crudd10/services/providers/storage_answer_item.dart';

class StorageAnsProvider extends ChangeNotifier {
  final FirebaseStorage ansstorage = FirebaseStorage.instance;
  List<StorageAnswerItem> _ansItem = [];

  List<StorageAnswerItem> get ansItem => _ansItem;

  Future<void> fetchAnsItems(String Path) async {
    _ansItem = [];
    final ListResult ansresult = await ansstorage.ref(Path).listAll();
    for (var prefix in ansresult.prefixes) {
      _ansItem.add(StorageAnswerItem(
          name: prefix.name, isFolder: true, path: prefix.fullPath));
    }

    for (var file in ansresult.items) {
      _ansItem.add(StorageAnswerItem(
          name: file.name, isFolder: false, path: file.fullPath));
    }
    notifyListeners();
  }
}
