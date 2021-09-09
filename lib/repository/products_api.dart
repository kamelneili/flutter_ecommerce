import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:technoshop/models/product.dart';
//import 'package:technoshop/utilities/api_utilities.dart';


class ProductsAPI {

  List<Product> products=[];
  Future<List<Product>> fetchPosts() async {
  //  List<PostModel> posts = [];
  String baseUrl = '192.168.1.20';
    String products_api = 'flutter/technoshopapi/public/api/products';

   Uri uri= Uri.http(baseUrl,'$products_api');

    var response = await http.get(uri);
    List<Product> products = List<Product>();
    if( response.statusCode == 200 ){
      var jsonData = jsonDecode(  response.body);
      var data = jsonData["data"];
      data.map((product)=>products.add(
        Product.fromJson(product))).toList();
           //  data.map((post)=>posts.add(Post.fromJson(post))).toList();

      }
        //  print (products);

	  return products;

    }
    // search function
   Future <List<Product>> searchProducts(key) async{
   
   List<Product>products=[];
      //List<Product>p=[];

       String all_categories_api = 'flutter/technoshopapi/public/api/products/$key';
  String baseUrl = '192.168.1.20';

   Uri uri= Uri.http(baseUrl,'$all_categories_api');
   var response = await http.get(uri);
   if(response.statusCode==200){
     var jsondata=jsonDecode(response.body);
     var data=jsondata["data"];
     data.map((product)=>products.add(Product.fromJson(product))).toList();
    //print(products);
    //print (key);
     return products;
   }
 }


  

}