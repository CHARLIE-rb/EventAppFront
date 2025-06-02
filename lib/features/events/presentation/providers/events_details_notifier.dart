import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/domain/usecases/forWidgets/get_all_employee_expandible_items_list.dart';
import 'package:flutterv1/shared/widgets/expandable_item.dart';

class EventsDetailsNotifier extends ChangeNotifier {
  final GetAllEmployeeExpandibleItemsList _getAllEmployeeExpandibleItemsList;
  EventsDetailsNotifier(this._getAllEmployeeExpandibleItemsList);

  Future<List<ExpandableItem>> getAllEmployeeExpandibleItemsList() async {
    try {
      return _getAllEmployeeExpandibleItemsList();
    } catch (e) {
      throw Exception('Failed to load employee expandible items: $e');
    }
  }
}
