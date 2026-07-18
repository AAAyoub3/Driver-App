<<<<<<< HEAD
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_item.dart';
import 'package:flowery/modules/order_tracking/data/models/responses/order_model.dart';
import 'package:flowery/modules/order_tracking/presentation/helpers/order_states_helper.dart';
import 'package:flowery/modules/order_tracking/presentation/screens/order_tracking_screen.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/cubit/order_details_view_model.dart';
import 'package:flowery/modules/order_tracking/presentation/view_models/states/order_details_state.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/changing_state_button.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/custom_address_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/custom_order_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/custom_payment_container.dart';
import 'package:flowery/modules/order_tracking/presentation/widgets/containers/status_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockOrderDetailsViewModel extends MockCubit<OrderDetailsState>
    implements OrderDetailsViewModel {}

void main() {
  late MockOrderDetailsViewModel cubit;

  final fakeOrder = OrderModel(
    acceptedAt: "Today",
    driverId: "driverId",
    email: "test@test.com",
    firstName: "John",
    lastName: "Doe",
    orderId: "1",
    orderNumber: "#123",
    phone: "01000000000",
    photo: "",
    status: "Picked",
    storeAddress: "Flower Store Address",
    storeImage: "",
    storeName: "Flower Store",
    totalPrice: 500,
    userAddress: "User Address",
    userName: "Ahmed",
    userPhoto: "",
    userId: "user1",
    vehicleNumber: "ABC123",
    paymentMethod: "Cash",
    items: [
      OrderItem(
        itemCost: "250",
        itemCount: "2",
        itemIcon: "",
        itemTitle: "Red Roses",
      ),
    ],
  );

  Widget buildWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<OrderDetailsViewModel>.value(
          value: cubit,
          child: const OrderDetailsScreen(),
        ),
      ),
    );
  }

  setUp(() {
    cubit = MockOrderDetailsViewModel();
  });

  group('OrderDetailsScreen', () {
    testWidgets(
      'shows loading indicator while loading order',
      (tester) async {
        when(() => cubit.state).thenReturn(
          const OrderDetailsState(
            isLoadingOrder: true,
          ),
        );

        whenListen(
          cubit,
          const Stream<OrderDetailsState>.empty(),
        );

        await tester.pumpWidget(buildWidget());

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );
    

    testWidgets(
  'renders all widgets when order is loaded',
  (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    when(() => cubit.state).thenReturn(
      OrderDetailsState(
        isLoadingOrder: false,
        currentOrderState: OrderStates.firstState,
        order: fakeOrder,
      ),
    );

    whenListen(
      cubit,
      Stream.value(
        OrderDetailsState(
          isLoadingOrder: false,
          currentOrderState: OrderStates.firstState,
          order: fakeOrder,
        ),
      ),
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      expect(find.byType(StatusContainer), findsOneWidget);
      expect(find.byType(CustomAddressContainer), findsNWidgets(2));
      expect(find.byType(CustomOrderContainer), findsOneWidget);
      expect(find.byType(CustomPaymentContainer), findsNWidgets(2));
      expect(find.byType(ChangingStateButton), findsOneWidget);
    });
  },
);

testWidgets(
  'renders all order items',
  (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final order = OrderModel(
      acceptedAt: fakeOrder.acceptedAt,
      driverId: fakeOrder.driverId,
      email: fakeOrder.email,
      firstName: fakeOrder.firstName,
      lastName: fakeOrder.lastName,
      orderId: fakeOrder.orderId,
      orderNumber: fakeOrder.orderNumber,
      phone: fakeOrder.phone,
      photo: fakeOrder.photo,
      status: fakeOrder.status,
      storeAddress: fakeOrder.storeAddress,
      storeImage: fakeOrder.storeImage,
      storeName: fakeOrder.storeName,
      totalPrice: fakeOrder.totalPrice,
      userAddress: fakeOrder.userAddress,
      userName: fakeOrder.userName,
      userPhoto: fakeOrder.userPhoto,
      userId: fakeOrder.userId,
      vehicleNumber: fakeOrder.vehicleNumber,
      paymentMethod: fakeOrder.paymentMethod,
      items: [
        OrderItem(
          itemCost: '100',
          itemCount: '1',
          itemIcon: '',
          itemTitle: 'Rose',
        ),
        OrderItem(
          itemCost: '200',
          itemCount: '2',
          itemIcon: '',
          itemTitle: 'Tulip',
        ),
      ],
    );

    final state = OrderDetailsState(
      isLoadingOrder: false,
      order: order,
    );

    when(() => cubit.state).thenReturn(state);

    whenListen(
      cubit,
      Stream.value(state),
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomOrderContainer), findsNWidgets(2));
      expect(find.text('Rose'), findsOneWidget);
      expect(find.text('Tulip'), findsOneWidget);
    });
  },
);

    testWidgets(
  'shows snackbar when error message is emitted',
  (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final errorState = OrderDetailsState(
      isLoadingOrder: false,
      errorMessage: 'Something went wrong',
      order: fakeOrder,
    );

    when(() => cubit.state).thenReturn(errorState);

    whenListen(
      cubit,
      Stream.fromIterable([errorState]),
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
    });
  },
);


=======
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
>>>>>>> origin/module/order_tracking
  });
}