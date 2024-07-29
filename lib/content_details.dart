import 'package:flutter/material.dart';

class ImageDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const ImageDetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildImage(image),
          ),
          if (title.isNotEmpty || subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return image.startsWith('http')
        ? Image.network(image, fit: BoxFit.cover, width: double.infinity)
        : Image.asset(image, fit: BoxFit.cover, width: double.infinity);
  }
}