import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String title;
  final List<String> ingredients;

  const Recipe({required this.title, required this.ingredients});

  @override
  List<Object?> get props => [title, ingredients];
}