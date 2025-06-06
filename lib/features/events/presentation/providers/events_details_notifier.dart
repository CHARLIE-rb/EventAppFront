import 'package:flutter/material.dart';
import 'package:events_app/features/events/domain/usecases/forWidgets/get_all_employee_expandible_items_list.dart';
import 'package:events_app/shared/presentation/widgets/expandable_item.dart';

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
