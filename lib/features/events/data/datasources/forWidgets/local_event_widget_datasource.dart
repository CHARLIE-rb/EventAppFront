import 'package:flutterv1/features/events/data/datasources/forWidgets/event_widget_datasource.dart';
import 'package:flutterv1/features/events/data/datasources/forWidgets/expandible_items.dart';
import 'package:flutterv1/features/events/data/datasources/forWidgets/images_alignment_list.dart';
import 'package:flutterv1/shared/presentation/widgets/expandable_item.dart';
import 'package:flutterv1/shared/presentation/widgets/for_expandible_align_plus_image.dart';

class EventWidgetDataSourceImpl implements EventWidgetDataSource {
  @override
  Future<List<String>> get getAllClothesNames async => clothesNames;

  @override
  Future<List<ExpandableItem>> get getAllEmployeeExpandibleItemsList async =>
      employeeExpandibleItemsList;

  @override
  Future<List<ImageLikePint>> get getAllImagesPlusAlignments async =>
      imagesPlusAlignments;

  @override
  Future<List<String>> get getAllMoreDetailsList async => moreDetailsList;
}
