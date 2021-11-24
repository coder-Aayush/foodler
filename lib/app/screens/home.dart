import 'dart:developer';
import 'dart:ui';
import 'package:foodler/app/models/item.models.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:foodler/app/providers/item.provider.dart';
import 'package:foodler/app/widgets/category.dart';
import 'package:foodler/app/widgets/item_card.dart';
import 'package:foodler/app/widgets/sized_box.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<ItemState>().getAllItems();
      context.read<ItemState>().getCategory();
    }
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        log("at the end of list");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [const Color(0xFFd8c5f4), const Color(0xffc8f8fb)],
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomScrollView(
              controller: controller,
              slivers: [
                Space(height: 10),
                SliverToBoxAdapter(
                  child: Text(
                    "Welcome,",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Space(height: 10),
                SliverToBoxAdapter(
                  child: Text(
                    "Scroll and choose a category to explore the menu",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Space(height: 10),
                buildCategories(),
                Space(height: 30),
                buildItems(),
                Space(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildCategories() {
    return Consumer<ItemState>(builder: (_, state, __) {
      if (state.loading) {
        return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      } else {
        if (state.categories == null) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state.categories?.length == 0) {
          return SliverToBoxAdapter(child: Container());
        } else {
          return SliverToBoxAdapter(
            child: Container(
              height: 100,
              child: ListView.builder(
                  itemCount: state.categories?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Item item = state.categories?[index] ?? Item();
                    return Category(
                      image: item.image ?? "",
                      name: item.name ?? "",
                    );
                  }),
            ),
          );
        }
      }
    });
  }

  Widget buildItems() {
    return Consumer<ItemState>(builder: (_, state, __) {
      if (state.loading) {
        return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      } else if (state.error != null) {
        return SliverToBoxAdapter(
          child: Text(state.error!),
        );
      } else {
        if (state.items == null) {
          return SliverToBoxAdapter(child: CircularProgressIndicator());
        } else if (state.items?.length == 0) {
          return SliverToBoxAdapter(
            child: Center(child: Text("No Items Avaiable")),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => ItemCard(
                item: state.items![index],
              ),
              childCount: state.items?.length,
            ),
          );
        }
      }
    });
  }
}
