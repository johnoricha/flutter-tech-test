import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_task/features/recipe/data/models/ingredient_model.dart';
import 'package:tech_task/features/recipe/data/models/recipe_model.dart';
import 'package:tech_task/features/recipe/data/repository/recipes_repository.dart';
import 'package:tech_task/features/recipe/presentation/ingredients_page/cubits/recipes_state.dart';
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

    emit(state.copyWith(
        ingredients: ingredients.map((e) => e.toIngredient()).toList(),
        getIngredientsStateStatus: StateStatus.successState));
  }

  void getRecipes(List<String> ingredientNames) async {
    emit(state.copyWith(getRecipesStateStatus: StateStatus.loadingState));

    final ingredients = ingredientNames.join(',');

    final response = await _recipesRepository.getRecipes(ingredients);

    final recipes = response
        .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    emit(state.copyWith(
        recipes: recipes.map((e) => e.toRecipe()).toList(),
        getRecipesStateStatus: StateStatus.successState));
  }

  void toggleIngredientChecked(Ingredient ingredient, bool checked) {
    final ingredients = state.ingredients?.map((element) {
      if (element == ingredient) {
        element = ingredient.copyWith(isChecked: checked);
      }
      return element;
    }).toList();

    emit(state.copyWith(ingredients: ingredients));
  }

  void addToSelectedIngredients(Ingredient ingredient) {
    Set<Ingredient>? selectedIngredients = state.selectedIngredients;
    selectedIngredients = {...state.selectedIngredients, ingredient};
    emit(state.copyWith(selectedIngredients: selectedIngredients));

  }

  void removeFromSelectedIngredients(Ingredient ingredient) {
    final items =
        state.selectedIngredients.where((item) => ingredient != item).toSet();
    emit(state.copyWith(selectedIngredients: items));

  }
}
