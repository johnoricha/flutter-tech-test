import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'recipes_service.g.dart';

@RestApi()
abstract class RecipesService {
  factory RecipesService(Dio dio, {String baseUrl}) = _RecipesService;

  @GET('/ingredients')
  Future<HttpResponse<dynamic>> getIngredients();

  @GET('/recipes')
  Future<HttpResponse<dynamic>> getRecipes(
      @Query('ingredients') String ingredients);
}
