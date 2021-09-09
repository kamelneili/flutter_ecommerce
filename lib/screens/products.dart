import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/repository/products_api.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  ProductsAPI postsAPI = ProductsAPI();
  ProductBloc bloc1;
  @override
  void initState() {
    super.initState();
        BlocProvider.of<ProductBloc>(context).add(DoFetchEvent1());

  }
  var product_list = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: null,
              
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                        leading: Text(
                          prod_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          "\$$prod_price",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "\$$prod_old_price",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              decoration
                                  :TextDecoration.lineThrough),
                        ),
                    ),
                  ),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
