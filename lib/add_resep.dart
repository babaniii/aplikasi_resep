import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'model_resep.dart';

class AddRecipeScreen extends StatefulWidget {
  final Recipe? recipe;

  const AddRecipeScreen({Key? key, this.recipe}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _timeController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.recipe?.name ?? '');
    _timeController =
        TextEditingController(text: widget.recipe?.preparationTime ?? '');
    _ingredientsController =
        TextEditingController(text: widget.recipe?.ingredients ?? '');
    _instructionsController =
        TextEditingController(text: widget.recipe?.instructions ?? '');
  }

  void _saveRecipe() async {
    final recipe = Recipe(
      id: widget.recipe?.id,
      name: _nameController.text,
      preparationTime: _timeController.text,
      ingredients: _ingredientsController.text,
      instructions: _instructionsController.text,
    );

    if (widget.recipe == null) {
      await DBHelper.insertRecipe(recipe);
    } else {
      await DBHelper.updateRecipe(recipe);
    }

    Navigator.pop(context);
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Tambah Resep' : 'Edit Resep'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: _inputDecoration('Nama Resep'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _timeController,
                decoration: _inputDecoration('Waktu Persiapan'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ingredientsController,
                decoration: _inputDecoration('Bahan-Bahan'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _instructionsController,
                decoration: _inputDecoration('Langkah-Langkah'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text(widget.recipe == null ? 'Simpan' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
