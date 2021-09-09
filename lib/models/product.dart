class Product {
  String id, title, content, featuredImage, price, oldPrice;

  int userId, categoryId;

  Product(this.id, 
  this.title,
    this.price,
       this.oldPrice, // this.categoryId

  this.content, 
  this.featuredImage, 
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        json['id'].toString(),
        json['title'].toString(),
        json['price'].toString(),
        json['oldPrice'].toString(),
                json['content'].toString(),

        json['featured_image'].toString(),
      );
}
