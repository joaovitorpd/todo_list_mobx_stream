// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_list_mobx_stream/pages/home/models/item_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final listItems = BehaviorSubject<List<ItemModel>>.seeded([]);
  final filter = BehaviorSubject<String>.seeded('');

  late ObservableStream output;

  _HomeControllerBase() {
    output = Rx.combineLatest2<List<ItemModel>, String, List<ItemModel>>(
        listItems.stream, filter.stream, (list, filter) {
      if (filter.isEmpty) {
        return list;
      } else {
        return list
            .where((item) =>
                item.title!.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
    }).asObservable(initialValue: []);
  }

  @computed
  int get totalChecked =>
      output.value.where((item) => item.check == true).length;

  setFilter(String value) => filter.add(value);

  @action
  addItem(ItemModel model) {
    //The line below will guarantee that this "list" will be a new "List<ItemModel>"
    var list = List<ItemModel>.from(listItems.value);
    list.add(model);
    listItems.add(list);
    //listItems.add(listItems.value..add(model)); - simplified notation for the above code
  }

  @action
  removeItem(ItemModel model) {
    var list = List<ItemModel>.from(listItems.value);
    list.removeWhere((item) => item.title == model.title);
    listItems.add(list);
  }
}
