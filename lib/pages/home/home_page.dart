import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_list_mobx_stream/pages/home/components/item_widget.dart';
import 'package:todo_list_mobx_stream/pages/home/home_controller.dart';
import 'package:todo_list_mobx_stream/pages/home/models/item_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  _dialog() {
    var model = ItemModel();

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Adicionar Item'),
            content: TextField(
              onChanged: model.setTitle,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Novo Item',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.addItem(model);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.setFilter,
          decoration: const InputDecoration(hintText: "Pesquisa..."),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Observer(
              builder: (_) {
                return Text("${controller.totalChecked}");
              },
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.output.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: controller.output.data.length,
              itemBuilder: (_, index) {
                var item = controller.output.data[index];
                return ItemWidget(
                  item: item,
                  removeClicked: () {
                    controller.removeItem(item);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _dialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
