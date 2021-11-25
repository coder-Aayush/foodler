import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodler/app/models/item.models.dart';
import 'package:foodler/app/providers/item.provider.dart';
import 'package:foodler/app/widgets/cutom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({Key? key}) : super(key: key);

  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final TextEditingController _productNameController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<ItemState>()..setItem = Item();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(),
          ),
          Consumer<ItemState>(builder: (_, state, __) {
            return InkWell(
              onTap: () {
                try {
                  pickImage(state);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: CircleAvatar(
                maxRadius: 40,
                backgroundImage: (state.itemData.image != null)
                    ? FileImage(File(state.itemData.image!))
                    : null,
              ),
            );
          }),
          SizedBox(height: 20),
          CustomTextField(
            keyboardType: TextInputType.name,
            title: "Product Name",
            controller: _productNameController,
          ),
          SizedBox(height: 20),
          Consumer<ItemState>(builder: (_, state, __) {
            if (!state.loading) {
              return TextButton(
                  onPressed: () async {
                    await state.addItem(
                        state.itemData..name = _productNameController.text);
                    Navigator.pop(context);
                  },
                  child: Text("Create"));
            } else if (state.error != null) {
              return Column(
                children: [
                  Text(state.error!),
                  TextButton(
                      onPressed: () => state.addItem(
                          state.itemData..name = _productNameController.text),
                      child: Text("Retry"))
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
        ],
      ),
    );
  }

  void pickImage(ItemState state) async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        state.setItemData = state.itemData..image = image.path;
      } else {
        throw "Faild to Pick Image";
      }
    } catch (e) {
      log(e.toString());
      throw "Faild to Pick Image";
    }
  }
}
