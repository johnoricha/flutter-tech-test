import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_task/features/recipe/di/app_initializer.dart';
import 'package:tech_task/features/recipe/presentation/home_page/cubits/recipes_cubit.dart';
import 'package:tech_task/features/recipe/presentation/home_page/cubits/recipes_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RecipesCubit _recipesCubit;

  @override
  void initState() {
    _recipesCubit = AppInitializer.getIt<RecipesCubit>();
    _recipesCubit.getIngredients();
    super.initState();
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: state.ingredients?.length,
                    itemBuilder: (context, index) {
                      return Text(state.ingredients?[index].title ?? '');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
