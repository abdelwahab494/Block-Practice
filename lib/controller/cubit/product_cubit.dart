import 'package:bloc_cubit_practice/data/models/product_model.dart';
import 'package:bloc_cubit_practice/repositories/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());
  ProductRepo productRepo = ProductRepo();

  Future<void> getProductsData() async {
    try {
      final List<ProductModel> productsList = await productRepo
          .getProductsData();
      emit(ProductLoaded(productsList));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
