class ProductData{
  late final List<ProductModel> list;
  ProductData.fromjson(Map<String,dynamic> json){
    list = List.from(json["data"]??[]).map((e) => ProductModel.fromJson(e)).toList();
  }
}
class ProductModel{
  late final num categoryId,id,priceBeforeDiscount,price,discount,amount;
  late final String title,description,code,image,createdAt;
  late final bool isActive;
  late  bool isFavorite;
  late final UnitModel unit;
  late final List<ProductImage> images;
  void togegle(){
    isFavorite = !isFavorite;
  }
  ProductModel.fromJson(Map<String,dynamic> json){
categoryId = json["category_id"]??0;
id = json["id"]??0;
priceBeforeDiscount = json["price_before_discount"]??0;
price = json["price"]??0;
discount = json["discount"]??0;
amount = json["amount"]??0;
title = json["title"]??"";
description = json["description"]??"";
code = json["code"]??"";
image = json["main_image"]??"";
createdAt = json["created_at"]??"";
isActive = json["is_active"]==1;
isFavorite = json["is_favorite"]??false;
unit = UnitModel.fromJson(json["unit"]??{});
images = List.from(json["images"]??[]).map((e) => ProductImage.fromJson(e)).toList();
}
}
class UnitModel{
  late final num id;
  late final String name,type,createdAt,updatedAt;
  UnitModel.fromJson(Map<String,dynamic> json){
    id =json["id"]??0;
    name =json["name"]??"";
    type =json["type"]??"";
    createdAt =json["created_at"]??"";
    updatedAt =json["updated_at"]??"";
  }
}
class ProductImage{
  late final String name ,url;
  ProductImage.fromJson(Map<String,dynamic> json){
    name = json["name"]??"";
    url = json["url"]??"";
  }
}
