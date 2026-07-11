import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/product_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/store_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/user_entity.dart';
import 'package:flowery/modules/order_tracking/presentation/screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tDriverOrder = DriverOrderEntity(
    id: 'd1',
    driverId: 'driver1',
    order: OrderEntity(
      id: 'o1',
      state: 'completed',
      orderNumber: '#123624',
      totalPrice: 300,
      paymentType: 'cash',
      user: UserEntity(firstName: 'Omar', lastName: 'Khaled'),
      orderItems: [
        OrderItemEntity(
          product: ProductEntity(id: 'p1', price: 500),
          price: 500,
          quantity: 1,
          id: 'item1',
        ),
      ],
    ),
    store: StoreEntity(
      name: 'Elevate FlowerApp Store',
      address: '123 Fixed Address, City, Country',
    ),
  );

  testWidgets('view order details', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderDetailsScreen(driverOrder: tDriverOrder),
      ),
    );

    expect(find.text('Order details'), findsOneWidget);
    expect(find.text('#123624'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
    expect(find.text('Elevate FlowerApp Store'), findsOneWidget);
    expect(find.text('Omar Khaled'), findsOneWidget);
    expect(find.text('Egp 300'), findsOneWidget);
    expect(find.text('Cash on delivery'), findsOneWidget);
    expect(find.text('X1'), findsOneWidget);
    expect(find.text('EGP 500'), findsOneWidget);
  });

  testWidgets('view state of payment', (tester) async {
    const orderWithDifferentPayment = DriverOrderEntity(
      id: 'd2',
      order: OrderEntity(
        orderNumber: '#123999',
        paymentType: 'card',
        totalPrice: 100,
      ),
      store: StoreEntity(name: 'Store'),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: OrderDetailsScreen(driverOrder: orderWithDifferentPayment),
      ),
    );

    expect(find.text('card'), findsOneWidget);
  });
}