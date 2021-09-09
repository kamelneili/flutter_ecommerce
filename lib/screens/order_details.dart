import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/blocs/category_bloc%20.dart';
import 'package:technoshop/blocs/product_bloc.dart';
import 'package:technoshop/models/Cart.dart';
import 'package:technoshop/models/category.dart';
import 'package:technoshop/models/order.dart';
import 'package:technoshop/screens/category_products.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/navigation_drawer.dart';

class OrderDetails extends StatefulWidget {
  Order order;
  OrderDetails({this.order});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  //PostsAPI postsAPI = PostsAPI();
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(DoFetchCartItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        //  backgroundColor: Color(0xFF332F43),
        elevation: 0,

        centerTitle: true,
        title: Text('Order Details'),
      ),
      drawer: NavigationDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                          SizedBox(width: 30),

                Text('Code:',style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                SizedBox(width: 15),
                Text(widget.order.code,
                     style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )
                    ),
                              SizedBox(width: 50),

                Row(
                  children: [
                    Text('Total:' ,style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                    SizedBox(width: 15),
                    Text(widget.order.total.toString(),
                         style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )
                         ),
                          Text("DT",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
            if (state is CartLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartItemFetchSuccess) {
              if (state.cart == null)
                return Container();
              else
                //widget.somme=state.cart.total;

                return ListView.builder(
                    padding: const EdgeInsets.only(left:20.0,right:20,top:50),
                    itemCount: state.cart.cartItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: drawSingleRow(state.cart.cartItems[index]),
                      );
                    });
            }
            //
            //
            //
            //
            //
          }),
        ],
      ),
    );
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
                      Text(cartItem.qty.toString()),
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
