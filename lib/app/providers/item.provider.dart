import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:foodler/app/helpers/storage.dart';

import 'package:foodler/app/models/item.models.dart';

class ItemState extends ChangeNotifier {
  // refs
  final CollectionReference itemRef =
      FirebaseFirestore.instance.collection("items");
  final CollectionReference cateGoryRef =
      FirebaseFirestore.instance.collection("category");

  final _foodSnapshot = <DocumentSnapshot>[];
  List<Item>? get items =>
      _foodSnapshot.map((e) => Item.fromMap(e.data())).toList();

  int _limit = 5;

  List<Item>? _category;
  List<Item>? get categories => _category;
  set setCategories(List<Item> categories) {
    _category = categories;
    notifyListeners();
  }

  Item? _item;
  Item? get item => _item;
  set setItem(Item item) {
    _item = item;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  String? _error;
  String? get error => _error;
  set setError(String error) {
    _error = error;
    notifyListeners();
  }

  getAllItems() async {
    try {
      final data = await getItems(_limit,
          startAfter: _foodSnapshot.isNotEmpty ? _foodSnapshot.last : null);
      _foodSnapshot.addAll(data.docs);
      notifyListeners();
    } catch (e) {
      log(e.toString());
      setLoading = false;
      setError = "Couldn't Fetch Items";
    }
  }

  addItem(Item item, File image) async {
    try {
      var id = itemRef.doc().id;
      _loading = true;
      notifyListeners();
      if (item.image != null) {
        var url = await StorageHelper().uploadFile(image);
        item.image = url;
      }
      await itemRef.doc(id).set(item.toMap());
      setLoading = false;
    } catch (e) {
      setLoading = false;
      setError = "Error Fetching Image";
      log(e.toString());
    }
  }

  getCategory() async {
    try {
      _loading = false;
      setCategories = (await cateGoryRef.get())
          .docs
          .map((e) => Item.fromMap(e.data()))
          .toList();
      setLoading = false;
    } catch (e) {
      setLoading = true;
      setError = "Error Fetching Categories";
      log(e.toString());
    }
  }

  getItems(int limit, {DocumentSnapshot? startAfter}) async {
    var item = itemRef.orderBy("name").limit(limit);
    if (startAfter == null) {
      return (item.get());
    } else {
      return (item.startAfterDocument(startAfter).get());
    }
  }
}
