import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_responsi/controllers/favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Favorit')),
      body: Obx(() {
        final favorites = controller.favorites;

        if (favorites.isEmpty) {
          return const Center(child: Text('Belum ada anime favorit'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final fav = favorites[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF492180),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () => Get.toNamed('/detail', arguments: fav.id),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 50,
                    height: 70,
                    child: fav.posterImage != null
                        ? Image.network(
                            fav.posterImage!,
                            webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          )
                        : const Icon(Icons.movie),
                  ),
                ),
                title: Text(
                  fav.titles,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(fav.averageRating?.toString() ?? '-'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.removeFavorite(fav.id),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}