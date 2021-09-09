import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/blocs/Order_bloc.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/models/Cart.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/navigation_drawer.dart';
import 'package:technoshop/screens/orders.dart';

class CartItems extends StatefulWidget {
  int somme = 0;
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  int cartId;
  int total;
  raisedButton() {
    if (isLoggedIn) {
      return RaisedButton(
          color: kPrimaryColor,

          // color: Colors.redAccent,

          child: Text(
            'Check out',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            return showDialog(
              context: context,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0)), //this right here

                child: Container(
                  height: 200.0,
                  width: 400.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          """ 
Are you sure you want to order ?                          """,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                              onPressed: () {
                                //SharedPreferences pref = await SharedPreferences.getInstance();
                                //  int userId = pref.getInt('id');
                                // print(userId);
                                //String token = pref.getString('token');
                                // print(token);
                                BlocProvider.of<OrderBloc>(context).add(
                                    AddOrderEvent(
                                        cartId: cartId, total: total));
                                //      print(cartId);

                                BlocProvider.of<OrderBloc>(context)
                                    .add(OrderFetchEvent());

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return Orders(
                                      cartId: cartId); //cartId:widget.cartId
                                }));
                              } //Navigator.of(context, rootNavigator: true).pop()

                              ),
                          FlatButton(
                              child: const Text(
                                "No",
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
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

              //
            );
          });
    } else
      return Container();
  }

  bool isLoggedIn = false;
  SharedPreferences sharedPreferences;
  String token;
  _checkToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token');
    // print(token);
    setState(() {
      if (token == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
    });
  }

  getCartId(int id) {
    return cartId = id;
  }

  //PostsAPI postsAPI = PostsAPI();
  void initState() {
    super.initState();

    cartId = null;
    total = 0;
    _checkToken();

    //BlocProvider.of<OrderBloc>(context).add(AddOrderEvent());

    BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text('My Cart'),
      ),
      drawer: NavigationDrawer(),
      body: PageView(children: <Widget>[
        BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
          if (!isLoggedIn) {
            return Center(child: Text("Empty cart"));
          } else {
            if (state is CartLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartItemFetchSuccess) {
              if (state.cart == null)
                return Container();
              else
                //widget.somme=state.cart.total;

                return ListView.builder(
                    itemCount: state.cart.cartItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: drawSingleRow(state.cart.cartItems[index]),
                      );
                    });
            }
          }
        }),
      ]),
      bottomNavigationBar: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text(
                  'Total:',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                BlocBuilder<CartBloc, CartStates>(
                  builder: (context, state) {
                    if (!isLoggedIn) {
                      return Center(child: Text("0"));
                    } else {
                      if (state is CartLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is CartItemFetchSuccess) {
                        if (state.cart == null)
                          return Row(
                            children: [
                              Text("0",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("DT",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          );
                        else {
                          cartId = state.cart.id;
                          total = state.cart.total;

                          return Row(
                            children: [
                              Text(state.cart.total.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text("DT",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          );

                          setState(() {
                            cartId = state.cart.id;
                          });
                        }
                      }
                    }
                  },
                ),
                SizedBox(
                  width: 90,
                ),
                raisedButton(),
              ],
            ),
          ),
        ],
      ),
    );
    //

    //
  }

  Widget drawSingleRow(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                //image_location,
                // "assets/images/p1.jpg",
                cartItem.product.featuredImage,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(cartItem.product.title),
                    Row(children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      Text(cartItem.qty.toString()),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(
                                AddEvent(id: cartItem.product.id.toString()));
                            BlocProvider.of<CartBloc>(context)
                                .add(DoFetchCartItemsEvent());
                          }),
                    ])
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
