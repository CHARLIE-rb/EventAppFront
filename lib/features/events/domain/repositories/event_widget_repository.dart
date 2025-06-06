import 'package:events_app/shared/presentation/widgets/expandable_item.dart';
import 'package:events_app/shared/presentation/widgets/for_expandible_align_plus_image.dart';

abstract class EventWidgetRepository {
  Future<List<ExpandableItem>> get allEmployeeExpandibleItemsList;
  Future<List<String>> get allClothesNames;
  Future<List<ImageLikePint>> get allImagesPlusAlignments;
  Future<List<String>> get allMoreDetailsList;
}
