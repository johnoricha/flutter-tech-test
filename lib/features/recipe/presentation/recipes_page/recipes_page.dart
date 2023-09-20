import 'package:flutter/material.dart';

import '../home_page/cubits/recipes_state.dart';

class RecipesPage extends StatefulWidget {
  final List<Ingredient> ingredients;

  const RecipesPage({super.key, required this.ingredients});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe'),),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('Ingredients:'),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = widget.ingredients[index];

                    return Text(ingredient.title);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
