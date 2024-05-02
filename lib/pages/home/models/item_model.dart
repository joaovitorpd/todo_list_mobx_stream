// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:mobx/mobx.dart';
part 'item_model.g.dart';

class ItemModel = _ItemModelBase with _$ItemModel;

abstract class _ItemModelBase with Store {
  _ItemModelBase({this.title, this.check = false});

  @observable
  String? title;

  @observable
  bool? check;

  @action
  setTitle(String? value) => title = value;

  @action
  setCheck(bool? value) => check = value;
}
