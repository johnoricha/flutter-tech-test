import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tech_task/features/recipe/cubits/models/ingredient.dart';
import 'package:tech_task/features/recipe/cubits/models/recipe.dart';
import 'package:tech_task/features/recipe/cubits/recipes_cubit.dart';
import 'package:tech_task/features/recipe/cubits/recipes_state.dart';
import 'package:tech_task/features/recipe/data/models/ingredient_model.dart';
import 'package:tech_task/features/recipe/data/models/recipe_model.dart';
import 'package:tech_task/features/recipe/data/repository/recipes_repository.dart';
import 'package:tech_task/features/recipe/utils/state_status.dart';

class MockRepository extends Mock implements RecipesRepository {}

void main() {
  group('recipe test', () {
    late MockRepository mockRepository;
    late RecipesCubit recipesCubit;
    const expectedIngredients = [
      Ingredient(title: 'meat', useBy: '2022-09-02'),
      Ingredient(title: 'bread', useBy: '2022-09-02'),
      Ingredient(title: 'ham', useBy: '2022-09-02')
    ];
    const expectedRecipes = [
      Recipe(title: 'meat', ingredients: ['meat', 'bread', 'ham']),
      Recipe(title: 'bread', ingredients: ['meat', 'bread', 'ham']),
      Recipe(title: 'ham', ingredients: ['meat', 'bread', 'ham']),
    ];

    const recipesParam = ['meat', 'ham'];

    setUp(() {
      mockRepository = MockRepository();
      recipesCubit = RecipesCubit(mockRepository);
    });

    blocTest(
      'test getRecipes returns success',
      build: () {
        when(() => mockRepository.getRecipes(recipesParam.join(',')))
            .thenAnswer((_) async => [
                  RecipeModel(
                      title: 'meat',
                      ingredients: ['meat', 'bread', 'ham']).toJson(),
                  RecipeModel(
                      title: 'bread',
                      ingredients: ['meat', 'bread', 'ham']).toJson(),
                  RecipeModel(
                      title: 'ham',
                      ingredients: ['meat', 'bread', 'ham']).toJson()
                ]);
        return recipesCubit;
      },
      act: (cubit) => cubit.getRecipes(recipesParam),
      expect: () => [
        RecipesState(
          getRecipesStateStatus: StateStatus.loadingState,
        ),
        RecipesState(
            getRecipesStateStatus: StateStatus.successState,
            recipes: expectedRecipes),
      ],
      verify: ((_) {
        verify(() => mockRepository.getRecipes(recipesParam.join(',')))
            .called(1);
      }),
    );

    blocTest(
      'test getIngredients returns success',
      build: () {
        when(() => mockRepository.getIngredients()).thenAnswer((_) async => [
              IngredientModel(title: 'meat', useBy: '2022-09-02').toJson(),
              IngredientModel(title: 'bread', useBy: '2022-09-02').toJson(),
              IngredientModel(title: 'ham', useBy: '2022-09-02').toJson()
            ]);
        return recipesCubit;
      },
      act: (cubit) => cubit.getIngredients(),
      expect: () => [
        RecipesState(
          getIngredientsStateStatus: StateStatus.loadingState,
        ),
        RecipesState(
            getIngredientsStateStatus: StateStatus.successState,
            ingredients: expectedIngredients),
      ],
      verify: ((_) {
        verify(() => mockRepository.getIngredients()).called(1);
      }),
    );

    blocTest(
      'add to selected ingredients',
      build: () => recipesCubit,
      act: (cubit) {
        final ingredient = Ingredient(title: 'Selected Ingredient', useBy: '');
        cubit.addToSelectedIngredients(ingredient);
      },
      expect: () {
        return [
          RecipesState(selectedIngredients: {
            Ingredient(title: 'Selected Ingredient', useBy: '')
          }),
        ];
      },
    );

    blocTest(
      'remove from selected ingredients',
      build: () => recipesCubit,
      act: (cubit) {
        final ingredient = Ingredient(title: 'Removed Ingredient', useBy: '');
        cubit.removeFromSelectedIngredients(ingredient);
      },
      expect: () {
        return [
          RecipesState(selectedIngredients: {}),
        ];
      },
    );
  });
}
