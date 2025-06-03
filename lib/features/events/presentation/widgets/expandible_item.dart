// lib/widgets/packing_list_with_images.dart
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterv1/shared/widgets/for_expandible_align_plus_image.dart';
import 'package:flutterv1/shared/widgets/mini/listado_puntos.dart';

class ExpandibleItem extends StatelessWidget {
  final List<ImageLikePint> itemsWithAlign;
  final List<String> itemsWithAlignNames;

  const ExpandibleItem({
    super.key,
    required this.itemsWithAlign,
    required this.itemsWithAlignNames,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListadoPuntos(namesList: itemsWithAlignNames),
          const SizedBox(height: 16),
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemsWithAlign.length,
            itemBuilder: (ctx, i) {
              return _GridImageTile(
                imageUrl: itemsWithAlign[i].imageUrl,
                alignment: itemsWithAlign[i].align,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GridImageTile extends StatelessWidget {
  final String imageUrl;
  final Alignment alignment;

  const _GridImageTile({required this.imageUrl, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Hero para la animación de transición
      child: Hero(
        tag: imageUrl,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imageUrl, fit: BoxFit.cover, alignment: alignment),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (_) => _FullImageDialog(imageUrl: imageUrl, alignment: alignment),
        );
      },
    );
  }
}

class _FullImageDialog extends StatelessWidget {
  final String imageUrl;
  final Alignment alignment;

  const _FullImageDialog({required this.imageUrl, required this.alignment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Center(
            child: Hero(
              tag: imageUrl,
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 1.0,
                maxScale: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.contain,
                    alignment: alignment,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  color: theme.colorScheme.onPrimary,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
