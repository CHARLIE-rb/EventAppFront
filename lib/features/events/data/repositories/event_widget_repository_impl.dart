import 'package:flutterv1/features/events/data/datasources/forWidgets/event_widget_datasource.dart';
import 'package:flutterv1/features/events/domain/repositories/event_widget_repository.dart';
import 'package:flutterv1/shared/widgets/expandable_item.dart';
import 'package:flutterv1/shared/widgets/for_expandible_align_plus_image.dart';

class EventWidgetRepositoryImpl extends EventWidgetRepository {
  final EventWidgetDataSource _eventWidgetDataSource;

  EventWidgetRepositoryImpl(this._eventWidgetDataSource);

  @override
  Future<List<String>> get allClothesNames =>
      _eventWidgetDataSource.getAllClothesNames;

  @override
  Future<List<ExpandableItem>> get allEmployeeExpandibleItemsList =>
      _eventWidgetDataSource.getAllEmployeeExpandibleItemsList;

  @override
  Future<List<ImageLikePint>> get allImagesPlusAlignments =>
      _eventWidgetDataSource.getAllImagesPlusAlignments;

  @override
  Future<List<String>> get allMoreDetailsList =>
      _eventWidgetDataSource.getAllMoreDetailsList;
}
