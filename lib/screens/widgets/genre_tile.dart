import 'package:flutter/material.dart';
import 'package:movies_app/data/genre_data_model.dart';

class GenreTile extends StatelessWidget {
  final Map<String, dynamic> genre;

  const GenreTile({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(genre['image']),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        genre['title'],
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}
