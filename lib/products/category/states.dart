part of'bloc.dart';

class CategoriesStates{}
class CategoriesLoadingState extends CategoriesStates{}
class CategoriesSuccessfulState extends CategoriesStates{
 final List<CategoryModel> list;

  CategoriesSuccessfulState({required this.list});
}
class CategoriesFailedState extends CategoriesStates{
  final String msg;

  CategoriesFailedState({required this.msg});
}