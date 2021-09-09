//import 'package:newsapp/repositories/post/post_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:technoshop/models/product.dart';
import 'package:technoshop/repository/products_api.dart';

class ProductBloc extends Bloc<ProductEvents, ProductStates> {
  @override
  ProductStates get initialState => LoadingState1();

  ProductsAPI repo;
  //AuthorsAPI aurepo ;
  ProductBloc(ProductStates initialState, this.repo) : super(initialState);
  @override
  Stream<ProductStates> mapEventToState(ProductEvents event) async* {
    if (event is DoFetchEvent1) {
              

      yield LoadingState1();
      //authbloc.add(DoFetchEvent());
      try {
        var products = await repo.fetchPosts();
        // var authors= await aurepo.fetchAllAuthors();
        //yield authbloc.mapEventToState(DoFetchEvent);
        yield FetchSuccess1(products: products);
      } catch (e) {
        yield ErrorState1(message: e.toString());
      }
    }
  }
}
// events
class ProductEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class DoFetchEvent1 extends ProductEvents {}


// states
class ProductStates extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState1 extends ProductStates {}

class LoadingState1 extends ProductStates {}

class FetchSuccess1 extends ProductStates {
  List<Product> products;

  FetchSuccess1({this.products});
}

class ErrorState1 extends ProductStates {
  String message;
  ErrorState1({this.message});
}


