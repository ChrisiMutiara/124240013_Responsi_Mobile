import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_responsi/controllers/anime_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnimeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Keripikroll')),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.errorMessage),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.fetchAnimes,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final animes = controller.animes;

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.62,
          ),
          itemCount: animes.length,
          itemBuilder: (context, index) {
            final anime = animes[index];

            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Get.toNamed('/detail', arguments: anime.id),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF492180),
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: anime.posterImage != null
                          ? Image.network(
                              anime.posterImage!,
                              webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Icon(Icons.broken_image)),
                            )
                          : const Center(child: Icon(Icons.movie, size: 40)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anime.titles,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                anime.ageRating ?? '-',
                                style: const TextStyle(color: Color(0xFFCEBBFF)),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.star, size: 14, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(anime.averageRating?.toString() ?? '-'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}