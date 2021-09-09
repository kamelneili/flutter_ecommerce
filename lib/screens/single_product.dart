import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/models/product.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/screens/login.dart';

class SingleProduct extends StatefulWidget {
  final Product product;
  //final Post post;
  final heroTag;

  SingleProduct({this.heroTag, this.product});
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  List<int> ids = [];
  int position = 1;

  var description = Container(
      child: Text(
        "A style icon gets some love from one of today's top "
        "trendsetters. Pharrell Williams puts his creative spin on these "
        "shoes, which have all the clean, classicdetails of the beloved Stan Smith.",
        textAlign: TextAlign.justify,
        style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
      ),
      padding: EdgeInsets.all(16));

  void initState() {
    //  BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,

          centerTitle: false,
//backgroundColor: Color(0xFF332F43),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return HomePage();
              }));
            },
          ),
        ),
        body:
            BlocBuilder<ProductBloc, ProductStates>(builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding * 1.5),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      hero(widget.product),
                      Property(widget.product),
                    ],
                  ),
                ),

                //
                Description(widget.product)

                //
              ],
            ),
          );
        })

        //
        //
        );

    //
  }

//
  Widget Description(Product p) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 1.5,
        vertical: kDefaultPadding / 2,
      ),
      child: Text(
        widget.product.content,
        style: TextStyle(color: Colors.black, fontSize: 19.0),
      ),
    );
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //Image.asset("images/p4.jpg"),
          //Container(),
          Image.asset(
            "images/bag_button.png",
            width: 27,
            height: 30,
          ),
        ],
      ),
    );
  }

  //
  Widget hero(Product product) {
    return Container(
      child: Stack(
        children: <Widget>[
          Hero(
            tag: widget.heroTag,
            child: Image.network(
              widget.product.featuredImage,
              fit: BoxFit.cover,
              height: 300,
            ),
          ), //This
          // should be a paged
          // view.

          Positioned(
            width: 40,
            child: FloatingActionButton(
                heroTag: "btn2",
                elevation: 2,
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    if (ids.contains(position)) {
                      ids.remove(position);
                    } else {
                      ids.add(position);
                    }
                    setState(() {});
                  },
                  color: (ids.contains(position))
                      ? Colors.redAccent
                      : Colors.grey.shade400,
                ),
                backgroundColor: Colors.white,
                onPressed: () {}),
            bottom: 0,
            right: 80,
          ),
//********************** */
          Positioned(
            width: 40,
            child: FloatingActionButton(
              heroTag: "btn1",
              elevation: 2,
              child: Icon(Icons.add_shopping_cart),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                int userId = pref.getInt('id');
                // print(userId);
                String token = pref.getString('token');
                // print(token);
                if (token == null) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Login();
                  }));
                } else {
                  BlocProvider.of<CartBloc>(context)
                      .add(AddEvent(id: product.id.toString()));
                  return showDialog(
                    context: context,
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        height: 200.0,
                        color: kBackgroundColor,
                        width: 400.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                """ New item has been added to your cart
                          """,
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.done_all_outlined,
                              size: 30,
                              color: Colors.green,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                    child: Text("View your cart",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        )),
                                    onPressed: () {
                                      BlocProvider.of<CartBloc>(context)
                                          .add(DoFetchCartItemsEvent());

                                      Navigator.pushNamed(context, '/card');
                                    } //Navigator.of(context, rootNavigator: true).pop()

                                    ),
                                FlatButton(
                                    child: const Text("No continue",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        )),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    } //Navigator.of(context, rootNavigator: true).pop()

                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  return BlocListener<CartBloc, CartStates>(
                    listener: (context, state) {
                      if (state is AddSuccess) {
                        // return showDialog();
                        print('yes');
                        return Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Incremented!'),
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    },
                  );
                }
              },
              backgroundColor: Colors.redAccent,
            ),
            bottom: 0,
            right: 20,
          ),
        ],
      ),
    );
  }

//
  Widget Property(Product product) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text("Price"),
              Row(
                children: [
                  Text(
                    product.price,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                  Text(
                    "DT",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
