import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlanetImage extends StatelessWidget {
  const PlanetImage({super.key, required this.image});

  final String? image;

  Future<Uint8List> _fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Error loading image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _fetchImage('https://cors-anywhere.herokuapp.com/$image'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Image.asset(
              'images/default_image.jpeg',
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Image.memory(
            snapshot.data!,
            height: 200,
            width: 300,
          );
        }
      },
    );
  }
}
