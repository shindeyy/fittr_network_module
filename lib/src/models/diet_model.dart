class DietItem {
  final int id;
  final String name;
  final double quantity;
  final String unit;
  final String type;
  final String imageUrl;
  final Macros macros;
  final Actions actions;

  DietItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.type,
    required this.imageUrl,
    required this.macros,
    required this.actions,
  });

  factory DietItem.fromJson(Map<String, dynamic> json) {
    return DietItem(
      id: json['id'],
      name: json['name'],
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'],
      type: json['type'],
      imageUrl: json['imageUrl'],
      macros: Macros.fromJson(json['macros']),
      actions: Actions.fromJson(json['actions']),
    );
  }
}

class Macros {
  final double calories;
  final double carbs;
  final double fats;
  final double protein;

  Macros({
    required this.calories,
    required this.carbs,
    required this.fats,
    required this.protein,
  });

  factory Macros.fromJson(Map<String, dynamic> json) {
    return Macros(
      calories: (json['calories'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
    );
  }
}

class Actions {
  final bool isFavorite;

  Actions({required this.isFavorite});

  factory Actions.fromJson(Map<String, dynamic> json) {
    return Actions(
      isFavorite: json['isFavorite'],
    );
  }
}
