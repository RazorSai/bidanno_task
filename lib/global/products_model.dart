class ProductsModel{

  String Name;

  List<ProductsModel> productsList;

  ProductsModel();

  factory ProductsModel.fromJson(Map<String, dynamic> json){
    ProductsModel productsModel = ProductsModel();

    productsModel.Name = json["Name"];

    productsModel.productsList = (json["Children"] as List).map((e) => ProductsModel.fromJson(e)).toList();

    return productsModel;
  }

}