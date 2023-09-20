import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final String title;
  final String useBy;
  final bool isChecked;

  const Ingredient({
    required this.title,
    required this.useBy,
    this.isChecked = false,
  });

  Ingredient copyWith({bool? isChecked, bool? isEnabled}) => Ingredient(
    title: title,
    useBy: useBy,
    isChecked: isChecked ?? this.isChecked,
  );

  @override
  List<Object?> get props => [
    title,
    useBy,
    isChecked,
  ];
}