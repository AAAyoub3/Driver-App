import 'package:flowery/core/widgets/custom_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

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
          return CustomGridWidget(
            title: "Red Roses",
            image: "https://images.unsplash.com/photo-1518717213163-52f46dc581b4?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            price: 600,
            hasDiscount: true,
            oldPrice: 800,
            discount: 20,
          );
        },
      ),
    );
  }
}