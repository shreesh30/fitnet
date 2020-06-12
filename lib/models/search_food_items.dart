class SearchFoodItem{
  SearchFoodItem({this.recipeName,this.recipeDescription});
  final String recipeName;
  final String recipeDescription;

factory SearchFoodItem.fromJson(Map<String, dynamic> parsedJson){
  return SearchFoodItem(
    recipeName: parsedJson['recipe_name'],
    recipeDescription:parsedJson['recipe_description'] 
  );
}

}