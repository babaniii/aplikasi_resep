class Recipe {
  final int? id;
  final String name;
  final String preparationTime;
  final String ingredients;
  final String instructions;

  Recipe({
    this.id,
    required this.name,
    required this.preparationTime,
    required this.ingredients,
    required this.instructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'preparation_time': preparationTime,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      preparationTime: map['preparation_time'],
      ingredients: map['ingredients'],
      instructions: map['instructions'],
    );
  }
}
