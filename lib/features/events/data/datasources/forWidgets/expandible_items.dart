import 'package:flutter/material.dart';
import 'package:events_app/features/events/data/datasources/forWidgets/images_alignment_list.dart';
import 'package:events_app/features/events/presentation/widgets/expandible_item.dart';
import 'package:events_app/shared/presentation/widgets/expandable_item.dart';
import 'package:events_app/shared/presentation/widgets/mini/listado_puntos.dart';

final List<ExpandableItem> employeeExpandibleItemsList = [
  ExpandableItem(
    title: 'Ropa necesaria',
    icon: Icons.checkroom,
    body: ExpandibleItem(
      itemsWithAlign: imagesPlusAlignments,
      itemsWithAlignNames: clothesNames, // List<String>
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
