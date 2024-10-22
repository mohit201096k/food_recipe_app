// class RecipeModal{
//   String? appLabel;
//  String? appImgUrl;
//   double? appCalories;
//   String? appUrl;
//
//   RecipeModal({this.appCalories,this.appImgUrl,this.appLabel,this.appUrl});
//   factory RecipeModal.fromMap(Map recipe){
//     return RecipeModal(
//       appCalories: recipe["calories"],
//       appImgUrl: recipe["image"],
//       appLabel: recipe["label"],
//       appUrl: recipe["url"]
//     );
//   }
// }
class RecipeModal {
  late String appLabel;
  late String appImgUrl;
  late double appCalories;
  late String appUrl;

  RecipeModal({
    this.appLabel = "LABEL",
    this.appCalories = 0.000,
    this.appImgUrl = "IMAGE",
    this.appUrl = "URL",
  });

  factory RecipeModal.fromMap(Map recipe) {
    return RecipeModal(
      appLabel: recipe["label"] ?? "No label",
      appCalories: recipe["calories"] ?? 0.0,
      appImgUrl: recipe["image"] ?? "",
      appUrl: recipe["url"] ?? "",
    );
  }
}
