import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/usecases/users/get_users_by_ids.dart';
import 'package:flutter/material.dart';
import 'package:events_app/features/events/domain/usecases/forWidgets/get_all_employee_expandible_items_list.dart';
import 'package:events_app/shared/presentation/widgets/expandable_item.dart';

class EventsDetailsNotifier extends ChangeNotifier {
  final GetAllEmployeeExpandibleItemsList _getAllEmployeeExpandibleItemsList;
  final GetUsersByIds _getUsersByIds;
  EventsDetailsNotifier(
    this._getAllEmployeeExpandibleItemsList,
    this._getUsersByIds,
  );

  Future<List<ExpandableItem>> getAllEmployeeExpandibleItemsList() async {
    try {
      return _getAllEmployeeExpandibleItemsList();
    } catch (e) {
      throw Exception('Failed to load employee expandible items: $e');
    }
  }

  Future<List<User>?> getUsersByIds(List<String> userIds) async {
    if (userIds.isEmpty) {
      return [];
    }
    return _getUsersByIds(userIds);
  }
}
