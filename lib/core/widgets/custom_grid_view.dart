import 'package:flowery/core/widgets/custom_product_card.dart';
import 'package:flowery/features/occasions/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridView extends StatelessWidget {
  final int productsLength;
  final List<ProductEntity> products;
  const CustomGridView({
    super.key,
    required this.productsLength,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: REdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return CustomProductCard(
            title: products[index].title,
            image: products[index].imgCover,
            price: products[index].priceAfterDiscount.toDouble(),
            discount: products[index].discount.toDouble(),
            hasDiscount: products[index].discount > 0,
            oldPrice: products[index].price.toDouble(),
            sold: products[index].sold,
            quantity: products[index].quantity,
            images: products[index].images,
          );
        },
        itemCount: productsLength,
      ),
    );
  }
}
