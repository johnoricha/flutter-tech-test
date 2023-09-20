import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tech_task/features/recipe/presentation/ingredients_page/cubits/recipes_state.dart';

part 'ingredient_model.g.dart';

@JsonSerializable()
class IngredientModel extends Equatable {
  final String? title;
  @JsonKey(name: 'use-by')
  final String? useBy;

  IngredientModel({this.title, this.useBy});

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);

  Ingredient toIngredient() =>
      Ingredient(title: this.title ?? '', useBy: this.useBy ?? '');

  @override
  List<Object?> get props => [title, useBy];
}
