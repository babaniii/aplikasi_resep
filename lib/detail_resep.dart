import 'package:flutter/material.dart';
import 'model_resep.dart';
import 'add_resep.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddRecipeScreen(
                    recipe: recipe,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu Persiapan: ${recipe.preparationTime}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              'Bahan-Bahan:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(recipe.ingredients, style: const TextStyle(fontSize: 16)),
            const Divider(),
            Text(
              'Langkah-Langkah:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(recipe.instructions, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
