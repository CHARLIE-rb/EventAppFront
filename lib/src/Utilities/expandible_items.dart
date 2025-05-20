import 'package:flutter/material.dart';
import 'package:flutterv1/src/Utilities/images_alignment_list.dart';
import 'package:flutterv1/src/models/forWidgets/expandable_item.dart';
import 'package:flutterv1/src/widgets/event_detail_widgets/expandible_item.dart';
import 'package:flutterv1/src/widgets/mini/listado_puntos.dart';

final List<ExpandableItem> employeeExpandibleItemsList = [
  ExpandableItem(
    title: 'Ropa necesaria',
    icon: Icons.checkroom,
    body: ExpandibleItem(
      itemsWithAlign: imagesPlusAlignments,
      itemsWithAlignNames: imagesPlusAlignmentsNames, // List<String>
    ),
  ),
  ExpandableItem(
    title: 'Más detalles',
    icon: Icons.border_color_outlined,
    body: ListadoPuntos(
      namesList: moreDetailsList, // List<String>
    ),
  ),
];
