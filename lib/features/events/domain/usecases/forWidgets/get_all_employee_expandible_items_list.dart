import 'package:flutterv1/features/events/domain/repositories/event_widget_repository.dart';
import 'package:flutterv1/shared/widgets/expandable_item.dart';

class GetAllEmployeeExpandibleItemsList {
  final EventWidgetRepository _eventWidgetRepository;
  GetAllEmployeeExpandibleItemsList(this._eventWidgetRepository);
  Future<List<ExpandableItem>> call() async {
    try {
      return _eventWidgetRepository.allEmployeeExpandibleItemsList;
    } catch (e) {
      throw Exception('Failed to load employee expandible items: $e');
    }
  }
}
