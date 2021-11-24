import 'package:flutter/material.dart';
import 'package:foodler/app/models/item.models.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: [
                Positioned(
                  height: 150,
                  width: 150,
                  top: 40,
                  child: Card(
                    color: Colors.white.withOpacity(0.4),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(14)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          item.name ?? "",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: NetworkImage(item.image ?? ""),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
