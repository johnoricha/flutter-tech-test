import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_task/features/recipe/di/app_initializer.dart';
import 'package:tech_task/features/recipe/presentation/home_page/cubits/recipes_cubit.dart';
import 'package:tech_task/features/recipe/presentation/home_page/cubits/recipes_state.dart';
import 'package:tech_task/features/recipe/presentation/recipes_page/recipes_page.dart';
import 'package:tech_task/features/recipe/utils/state_status.dart';
import 'package:tech_task/features/recipe/utils/string_formatter.dart';

class IngredientsPage extends StatefulWidget {
  IngredientsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  late RecipesCubit _recipesCubit;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _recipesCubit = AppInitializer.getIt<RecipesCubit>();
    _recipesCubit.getIngredients();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesCubit, RecipesState>(
      bloc: _recipesCubit,
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: _buildHomePageBody(context, state)),
    );
  }

  Widget _buildHomePageBody(BuildContext context, RecipesState state) {
    if (state.getIngredientsStateStatus == StateStatus.loadingState) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text('Getting ingredients...')],
      ));
    }

    if (state.getIngredientsStateStatus == StateStatus.failedState) {
      return Center(child: Text('error'));
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Select lunch date'),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringFormatter.convertDateFormat(
                          value: selectedDate.toString(),
                          inputDateFormat: 'yyyy-MM-dd',
                          outputDateFormat: 'yyyy-MM-dd'),
                    ),
                    Icon(Icons.date_range)
                  ],
                ),
              ),
            ),
          ),
          Text('Select ingredients'),
          Expanded(
            child: ListView.builder(
                itemCount: state.ingredients?.length,
                itemBuilder: (context, index) {
                  final ingredient = state.ingredients?[index];

                  return AppListTileCheckBox(
                    title: ingredient?.title ?? '',
                    subTitle: ingredient?.useBy ?? '',
                    isChecked: ingredient?.isChecked ?? false,
                    onChanged: (checked) {
                      if (checked != null) {
                        late List<Ingredient> selectedIngredient;
                        if (state.selectedIngredients.isNotEmpty ?? false) {
                          selectedIngredient =
                              state.selectedIngredients.where((element) {
                            if ((element.title == ingredient?.title) &&
                                (element.useBy == ingredient?.useBy)) {
                              return true;
                            }
                            return false;
                          }).toList();
                          print('selectedIngredients: $selectedIngredient');
                        }
                        if (!checked) {
                          _recipesCubit.toggleIngredientChecked(
                              ingredient!, checked);
                          _recipesCubit.removeFromSelectedIngredients(
                              selectedIngredient.first);
                        } else {
                          _recipesCubit.addToSelectedIngredients(
                              ingredient ?? Ingredient(title: '', useBy: ''));
                          _recipesCubit.toggleIngredientChecked(
                              ingredient!, checked);
                        }
                      }
                    },
                  );
                }),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
                onPressed: () {
                  print('selected ingredients: ${state.selectedIngredients}');
                  if (state.selectedIngredients.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipesPage(
                                ingredients:
                                    state.selectedIngredients.toList())));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select ingredients')));
                  }
                },
                child: Text('Get Recipe')),
          )
        ],
      ),
    );
  }
}

class AppListTileCheckBox extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const AppListTileCheckBox({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isChecked,
      title: Text(title),
      subtitle: Text(subTitle),
      onChanged: onChanged,
    );
  }
}
