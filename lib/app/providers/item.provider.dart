import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:foodler/app/models/item.models.dart';

class ItemState extends ChangeNotifier {
  // refs
  final CollectionReference itemRef =
      FirebaseFirestore.instance.collection("items");
  final CollectionReference cateGoryRef =
      FirebaseFirestore.instance.collection("category");

  List<Item>? _category;
  List<Item>? get categories => _category;
  set setCategories(List<Item> categories) {
    _category = categories;
    notifyListeners();
  }

  List<Item>? _items;
  List<Item>? get items => _items;
  set setItems(List<Item> items) {
    _items = items;
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

  getAllItems(limit) async {
    try {
      setItems = (await itemRef.get())
          .docs
          .map((e) => Item.fromMap(e.data()))
          .toList();
    } catch (e) {
      setLoading = false;
      setError = "Couldn't Fetch Items";
    }
  }

  addItem() async {
    try {
      var id = cateGoryRef.doc().id;
      _loading = true;
      notifyListeners();
      Item item = Item()
        ..id = id
        ..categoryName = "pizza"
        ..image =
            "https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1788&q=80"
        ..name = "pizza";
      await cateGoryRef.doc(id).set(item.toMap());
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
}
