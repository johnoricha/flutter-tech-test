import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient extends Equatable {
  final String? title;
  @JsonKey(name: 'use-by')
  final String? useBy;

  Ingredient({this.title, this.useBy});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  @override
  List<Object?> get props => [title, useBy];
}
