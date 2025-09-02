import 'package:bloc_cubit_practice/controller/cubit/product_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductsData(),
      child: Scaffold(
        appBar: AppBar(title: Text("Products Screen"), centerTitle: true),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            switch (state) {
              case ProductLoading():
                return Center(
                  child: const CircularProgressIndicator(color: Colors.black),
                );
              case ProductLoaded():
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.537,
                    ),
                    itemCount: state.productsList.length,
                    itemBuilder: (context, index) {
                      final product = state.productsList[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xff004081),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Center(
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Color(0xff004081),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(10),
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      color: Color(0xff332e6e),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Gap(5),
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Gap(6),
                                  Text(
                                    "EGP ${product.price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "Review (${product.rating.rate})",
                                  //       style: TextStyle(
                                  //         color: Color(0xff332e6e),
                                  //       ),
                                  //     ),
                                  //     Gap(5),
                                  //     Icon(
                                  //       Icons.star,
                                  //       color: Color(0xFFFFD61E),
                                  //     ),
                                  //     Spacer(),
                                  //     GestureDetector(
                                  //       child: Icon(
                                  //         CupertinoIcons.add_circled_solid,
                                  //         color: Color(0xff004081),
                                  //         size: 38,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              case ProductError():
                return Center(
                  child: SelectableText(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
