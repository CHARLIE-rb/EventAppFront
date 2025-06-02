import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/data/datasources/forWidgets/expandible_items.dart';

class EventExpansionPanels extends StatefulWidget {
  const EventExpansionPanels({super.key});

  @override
  State<EventExpansionPanels> createState() => _EventExpansionPanels();
}

class _EventExpansionPanels extends State<EventExpansionPanels> {
  int? _openPanel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.zero,
      initialOpenPanelValue: _openPanel,
      expansionCallback: (i, open) {
        setState(() => _openPanel = open ? null : i);
      },
      children: List.generate(employeeExpandibleItemsList.length, (i) {
        final item = employeeExpandibleItemsList[i];
        return _buildPanel(
          value: i,
          icon: item.icon,
          title: item.title,
          body: item.body,
          theme: theme,
        );
      }),
    );
  }

  ExpansionPanelRadio _buildPanel({
    required int value,
    required IconData icon,
    required String title,
    required Widget body,
    required ThemeData theme,
  }) {
    return ExpansionPanelRadio(
      value: value,
      headerBuilder: (ctx, isOpen) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
              bottom: isOpen ? Radius.zero : Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: theme.textTheme.bodyLarge)),
            ],
          ),
        );
      },
      body: body,
    );
  }
}
