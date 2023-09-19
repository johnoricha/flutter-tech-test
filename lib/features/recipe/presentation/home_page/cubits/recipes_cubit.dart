import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:tech_task/features/recipe/data/models/ingredient_model.dart';
import 'package:tech_task/features/recipe/data/repository/recipes_repository.dart';
import 'package:tech_task/features/recipe/presentation/home_page/cubits/recipes_state.dart';
import 'package:tech_task/features/recipe/utils/state_status.dart';

class RecipesCubit extends Cubit<RecipesState> {
  final RecipesRepository _recipesRepository;

  RecipesCubit(this._recipesRepository) : super(RecipesState());

  void getIngredients() async {
    emit(state.copyWith(getIngredientsStateStatus: StateStatus.loadingState));

    final response = await _recipesRepository.getIngredients();

    final ingredients = response
        .map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
        .toList();

    logger.log(Level.debug, 'ingredients:' + ingredients.toString());

    emit(state.copyWith(
        ingredients: ingredients.map((e) => e.toIngredient()).toList(),
        getIngredientsStateStatus: StateStatus.successState));
  }

  void toggleIngredientChecked(int index, bool checked) {
    final ingredients = state.ingredients?.map((ingredient) {
      if (index == state.ingredients?.indexOf(ingredient)) {
        ingredient = ingredient.copyWith(isChecked: checked);
      }
      return ingredient;
    }).toList();

    emit(state.copyWith(ingredients: ingredients));
  }
}
