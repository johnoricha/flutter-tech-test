
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_task/features/recipe/data/repository/recipes_repository.dart';
import 'package:tech_task/features/recipe/presentation/home_page/cubits/recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {

  final RecipesRepository _recipesRepository;

  RecipesCubit(this._recipesRepository) : super(RecipesState());


  void getIngredients() async {
    final response = await _recipesRepository.getIngredients();
  }

}

