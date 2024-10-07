import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tres_astronautas/presentation/widgets/circular_clipper.dart';

class PlanetImage extends StatelessWidget {
  const PlanetImage({
    super.key,
    required this.image,
    required this.planetName,
  });

  final String? image;
  final String planetName;

  Future<Uint8List?> _fetchImage(String url) async {
    if (url.isEmpty) return null;

    // Intenta cargar la imagen desde una lista de URLs
    Future<Uint8List?> tryLoadImage(List<String> urls) async {
      for (var url in urls) {
        try {
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            return response.bodyBytes; // Retorna los bytes de la imagen si es exitosa
          }
        } catch (e) {
          print('Error al cargar la imagen desde $url: $e');
        }
      }
      return null; // Retorna null si todas las cargas fallan
    }

    // Intenta cargar la imagen desde diferentes URLs
    final imageData = await tryLoadImage([
      url,
      'https://corsproxy.io/?${url.replaceFirst('http://', 'https://')}',
      if (url.contains('caracteristicas.co'))
        'https://corsproxy.io/?https://humanidades.com/wp-content/uploads/2017/05/neptuno-planeta-min-e1494532094217.jpeg',
      'https://corsproxy.io/?$url',
    ]);

    return imageData; // Retorna los bytes de la imagen o null si todas las opciones fallan
  }

  double _getImageSize(double screenWidth) {
    if (screenWidth > 1400) return 550;
    if (screenWidth > 780) return 550;
    if (screenWidth > 500) return 450;
    return 500;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = _getImageSize(screenWidth);

    return FutureBuilder<Uint8List?>(
      future: _fetchImage(image!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          print('Error: ${snapshot.error}');
          return Center(
            child: Stack(
              children: [
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/tre-sastronautas.appspot.com/o/descarga.jpeg?alt=media&token=92186885-c77c-4e18-b298-18d8b98907c0',
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.cover,
                ),
                AutoSizeText(
                  'Could not Get Image, Sorry',
                  style: const TextStyle(color: Colors.white),
                  presetFontSizes: [18, 16, 14],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            ),
          );
        } else {
          return planetName == 'Saturn'
              ? Image.memory(
                  snapshot.data!,
                  height: imageSize,
                  width: imageSize * 1.6,
                  fit: BoxFit.cover,
                )
              : ClipPath(
                  clipper: CircularClipper(radius: 190.0),
                  child: Image.memory(
                    snapshot.data!,
                    height: imageSize,
                    width: imageSize,
                    fit: BoxFit.cover,
                  ),
                );
        }
      },
    );
  }
}
