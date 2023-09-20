import 'package:flutter/material.dart';
import 'package:tech_task/features/recipe/di/app_initializer.dart';

import 'features/recipe/ui/ingredients_page/ingredients_page.dart';

void main() async {
  await AppInitializer.initGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IngredientsPage(title: 'Ingredients'),
    );
  }
}
