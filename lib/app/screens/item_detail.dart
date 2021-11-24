import 'package:flutter/material.dart';
import 'package:foodler/app/models/item.models.dart';

class ItemDetail extends StatelessWidget {
  final Item item;
  const ItemDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name ?? ""),
      ),
      body: Column(
        children: [
          Image.network(
            item.image ?? "",
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text(
            item.name ?? "",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text("Price: " + (item.price ?? 0).toString(),
              style: Theme.of(context).textTheme.subtitle2)
        ],
      ),
    );
  }
}
