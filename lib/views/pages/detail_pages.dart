import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_responsi/controllers/detail_controller.dart';
import 'package:mobile_responsi/controllers/favorite_controller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final detailController = Get.find<DetailController>();
    final favController = Get.find<FavoriteController>();
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Obx(() {
        if (detailController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final anime = detailController.anime;

        if (anime == null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(detailController.errorMessage),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: detailController.fetchDetail,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final isFav = favController.isFavorite(anime.id);
        final imageUrl = anime.coverImage ?? anime.posterImage;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 220,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image, size: 48)),
                      )
                    : const Center(child: Icon(Icons.movie, size: 64)),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.titles,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(anime.averageRating?.toString() ?? '-'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${anime.ageRating ?? '-'} • ${anime.episodeCount ?? 'N/A'} Episodes',
                      style: const TextStyle(color: Color(0xFFCEBBFF)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Nonton'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            final added = await favController.toggleFavorite(anime);
                            Get.snackbar(
                              'Favorit',
                              added
                                  ? '${anime.titles} ditambahkan ke favorit'
                                  : '${anime.titles} dihapus dari favorit',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 1),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFav ? Colors.red : const Color(0xFF1A1A1A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          ),
                          child: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sinopsis',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(anime.cleanSynopsis),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}