import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_task/features/recipe/di/app_initializer.dart';
import 'package:tech_task/features/recipe/presentation/ingredients_page/cubits/recipes_cubit.dart';
import 'package:tech_task/features/recipe/presentation/ingredients_page/cubits/recipes_state.dart';


class RecipesPage extends StatefulWidget {
  final List<Ingredient> ingredients;

  const RecipesPage({super.key, required this.ingredients});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  late RecipesCubit _recipesCubit;

  @override
  void initState() {
    _recipesCubit = AppInitializer.getIt<RecipesCubit>();
    final ingredientNames = widget.ingredients.map((e) => e.title).toList();
    _recipesCubit.getRecipes(ingredientNames);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipesCubit, RecipesState>(
      bloc: _recipesCubit,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Recipes'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: state.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = state.recipes[index];

                      return SizedBox(
                        height: 100,
                        child: RecipeItem(
                            title: recipe.title, ingredients: recipe.ingredients),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeItem extends StatelessWidget {
  final String title;
  final List<String> ingredients;

  const RecipeItem({super.key, required this.title, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return Text(ingredients[index]);
              }),
        )
      ],
    );
  }
}
