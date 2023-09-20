import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_task/features/recipe/cubits/recipes_cubit.dart';
import '../data/repository/recipes_repository.dart';

class AppInitializer {
  static late GetIt getIt;

  AppInitializer._();

  static void close() {
    getIt.reset();
  }

  static void create() {
    _initRepos();
    _initBlocs();
  }

  static dynamic initGetIt() {
    getIt = GetIt.I;
    create();
  }

  static dynamic logout() async {
    try {
      await getIt.reset();
      await initGetIt();
    } catch (e) {
      logger.d(e);
    }
  }

  static void _initBlocs() {

    getIt.registerLazySingleton(
          () => RecipesCubit(
        AppInitializer.getIt<RecipesRepository>(),
      ),
    );
  }

  static void disposeInstance<T extends Cubit<T>>(T cubitInstance) {
    getIt.unregister(instance: cubitInstance);
  }

  static void _initRepos() {
    getIt.registerLazySingleton(() => RecipesRepository());
  }

}
