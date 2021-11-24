import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String name;
  final String image;
  const Category({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 30,
            backgroundImage: NetworkImage(image),
          ),
          Text(
            name,
            overflow: TextOverflow.clip,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
