import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_order_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/driver_orders_response_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/store_entity.dart';
import 'package:flowery/modules/order_tracking/domain/entities/user_entity.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/base_state/order_tracking_state.dart';
import 'package:flowery/modules/order_tracking/presentation/view_model/cubit/order_tracking_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_card_widget.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/order_stat_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderTrackingViewModel
    extends MockCubit<OrderTrackingState> implements OrderTrackingViewModel {}

void main() {
  late MockOrderTrackingViewModel mockViewModel;

  const tCompletedOrder = DriverOrderEntity(
    id: 'd1',
    driverId: 'driver1',
    order: OrderEntity(
      id: 'o1',
      state: 'completed',
      orderNumber: '#123624',
      totalPrice: 300,
      paymentType: 'cash',
      user: UserEntity(firstName: 'Omar', lastName: 'Khaled'),
      orderItems: [],
    ),
    store: StoreEntity(name: 'Flowery Store', address: 'Giza'),
  );

  const tCancelledOrder = DriverOrderEntity(
    id: 'd2',
    driverId: 'driver1',
    order: OrderEntity(
      id: 'o2',
      state: 'cancelled',
      orderNumber: '#123625',
      totalPrice: 200,
      paymentType: 'cash',
      user: UserEntity(firstName: 'Nour', lastName: 'Mohamed'),
      orderItems: [],
    ),
    store: StoreEntity(name: 'Flowery Store', address: 'Giza'),
  );

  setUp(() {
    mockViewModel = MockOrderTrackingViewModel();
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<OrderTrackingViewModel>.value(
        value: mockViewModel,
        child: child,
      ),
    );
  }

  testWidgets(
    'CircularProgressIndicator',
    (tester) async {
      when(() => mockViewModel.state).thenReturn(
        const OrderTrackingState(isLoadingOrders: true, orders: []),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          Scaffold(
            body: BlocBuilder<OrderTrackingViewModel, OrderTrackingState>(
              builder: (context, state) {
                if (state.isLoadingOrders && state.orders.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'error massage',
    (tester) async {
      when(() => mockViewModel.state).thenReturn(
        const OrderTrackingState(
          isLoadingOrders: false,
          orders: [],
          errorMessage: 'Network error',
        ),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          Scaffold(
            body: BlocBuilder<OrderTrackingViewModel, OrderTrackingState>(
              builder: (context, state) {
                if (state.errorMessage != null && state.orders.isEmpty) {
                  return Center(child: Text(state.errorMessage!));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(find.text('Network error'), findsOneWidget);
    },
  );

  testWidgets(
    'completed and cancelled orders number',
    (tester) async {
      when(() => mockViewModel.state).thenReturn(
        const OrderTrackingState(
          isLoadingOrders: false,
          orders: [tCompletedOrder, tCancelledOrder],
        ),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          BlocBuilder<OrderTrackingViewModel, OrderTrackingState>(
            builder: (context, state) {
              final orders = state.orders;
              final cancelledCount =
                  orders.where((o) => o.order?.state == 'cancelled').length;
              final completedCount =
                  orders.where((o) => o.order?.state == 'completed').length;

              return Scaffold(
                body: ListView(
                  children: [
                    OrderStatCardWidget(
                      count: cancelledCount,
                      label: 'Cancelled',
                      icon: Icons.cancel,
                      color: Colors.red,
                    ),
                    OrderStatCardWidget(
                      count: completedCount,
                      label: 'Completed',
                      icon: Icons.check_circle,
                      color: Colors.green,
                    ),
                    ...orders.map((o) => OrderCardWidget(driverOrder: o)),
                  ],
                ),
              );
            },
          ),
        ),
      );

      expect(find.text('1'), findsNWidgets(2)); 
      expect(find.text('Cancelled'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.byType(OrderCardWidget), findsNWidgets(2));
      expect(find.text('#123624'), findsOneWidget);
      expect(find.text('#123625'), findsOneWidget);
    },
  );

  testWidgets(
    'go to ordre details screen when press on container',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OrderCardWidget(driverOrder: tCompletedOrder),
          ),
        ),
      );

      await tester.tap(find.byType(OrderCardWidget));
      await tester.pumpAndSettle();

      expect(find.text('Order details'), findsOneWidget);
    },
  );
}