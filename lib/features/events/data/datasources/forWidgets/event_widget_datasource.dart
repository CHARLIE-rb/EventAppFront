import 'package:flutterv1/shared/widgets/expandable_item.dart';
import 'package:flutterv1/shared/widgets/for_expandible_align_plus_image.dart';

abstract class EventWidgetDataSource {
  Future<List<ExpandableItem>> get getAllEmployeeExpandibleItemsList;
  Future<List<String>> get getAllClothesNames;
  Future<List<ImageLikePint>> get getAllImagesPlusAlignments;
  Future<List<String>> get getAllMoreDetailsList;
}
