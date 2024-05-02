import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_list_mobx_stream/pages/home/models/item_model.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key, required this.item, required this.removeClicked});

  final ItemModel item;
  final Function()? removeClicked;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListTile(
          title:
              item.title != null ? Text(item.title!) : const Text('Sem titulo'),
          leading: Checkbox(
            value: item.check,
            onChanged: item.setCheck,
          ),
          trailing: IconButton(
            color: Colors.red,
            icon: const Icon(Icons.remove_circle),
            onPressed: removeClicked,
          ),
        );
      },
    );
  }
}
