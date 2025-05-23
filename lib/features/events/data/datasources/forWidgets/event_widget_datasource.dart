import 'package:flutterv1/features/events/data/datasources/forWidgets/expandible_items.dart';
import 'package:flutterv1/features/events/data/datasources/forWidgets/images_alignment_list.dart';
import 'package:flutterv1/shared/widgets/expandable_item.dart';
import 'package:flutterv1/shared/widgets/for_expandible_align_plus_image.dart';

abstract class EventWidgetDataSource {
  List<ExpandableItem> get getAllEmployeeExpandibleItemsList;
  List<String> get getAllClothesNames;
  List<ImageLikePint> get getAllImagesPlusAlignments;
  List<String> get getAllMoreDetailsList;
}

class EventWidgetDataSourceImpl implements EventWidgetDataSource {
  @override
  List<String> get getAllClothesNames => clothesNames;

  @override
  List<ExpandableItem> get getAllEmployeeExpandibleItemsList =>
      employeeExpandibleItemsList;

  @override
  List<ImageLikePint> get getAllImagesPlusAlignments => imagesPlusAlignments;

  @override
  List<String> get getAllMoreDetailsList => moreDetailsList;
}
