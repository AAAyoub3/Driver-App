@JsonSerializable()
class HomeResponseModel {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "metadata")
  Metadata? metadata;
  @JsonKey(name: "orders")
  List<Order>? orders;

  HomeResponseModel({
    this.message,
    this.metadata,
    this.orders,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) => _$HomeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseModelToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  int? currentPage;
  @JsonKey(name: "totalPages")
  int? totalPages;
  @JsonKey(name: "totalItems")
  int? totalItems;
  @JsonKey(name: "limit")
  int? limit;

  Metadata({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "orderItems")
  List<OrderItem>? orderItems;
  @JsonKey(name: "totalPrice")
  double? totalPrice;
  @JsonKey(name: "paymentType")
  PaymentType? paymentType;
  @JsonKey(name: "isPaid")
  bool? isPaid;
  @JsonKey(name: "isDelivered")
  bool? isDelivered;
  @JsonKey(name: "state")
  State? state;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "orderNumber")
  String? orderNumber;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "store")
  Store? store;
  @JsonKey(name: "shippingAddress")
  ShippingAddress? shippingAddress;
  @JsonKey(name: "paidAt")
  DateTime? paidAt;

  Order({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
    this.shippingAddress,
    this.paidAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "product")
  Product? product;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "_id")
  String? id;

  OrderItem({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "imgCover")
  String? imgCover;
  @JsonKey(name: "images")
  List<Image>? images;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "priceAfterDiscount")
  int? priceAfterDiscount;
  @JsonKey(name: "discount")
  int? discount;
  @JsonKey(name: "rateAvg")
  int? rateAvg;
  @JsonKey(name: "rateCount")
  int? rateCount;
  @JsonKey(name: "sold")
  int? sold;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "occasion")
  String? occasion;
  @JsonKey(name: "isSuperAdmin")
  bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

enum Image {
  @JsonValue("ba028e59-410f-43ac-aed5-f4f97c102b98-image_four.png")
  BA028_E59_410_F_43_AC_AED5_F4_F97_C102_B98_IMAGE_FOUR_PNG,
  @JsonValue("c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png")
  C0992_EC6_D3_C0_4_A54_B7_EC_4_CF000138367_IMAGE_TWO_PNG,
  @JsonValue("f89bc954-eb0d-4efb-928f-6717f77b69ed-image_one.png")
  F89_BC954_EB0_D_4_EFB_928_F_6717_F77_B69_ED_IMAGE_ONE_PNG,
  @JsonValue("5ed2d072-485b-4a53-a0fa-a41412791397-image_three.png")
  THE_5_ED2_D072_485_B_4_A53_A0_FA_A41412791397_IMAGE_THREE_PNG
}

enum PaymentType {
  @JsonValue("cash")
  CASH
}

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "lat")
  String? lat;
  @JsonKey(name: "long")
  String? long;

  ShippingAddress({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}

enum State {
  @JsonValue("pending")
  PENDING
}

@JsonSerializable()
class Store {
  @JsonKey(name: "name")
  Name? name;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "address")
  Address? address;
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "latLong")
  LatLong? latLong;

  Store({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

enum Address {
  @JsonValue("123 Fixed Address, City, Country")
  THE_123_FIXED_ADDRESS_CITY_COUNTRY
}

enum LatLong {
  @JsonValue("37.7749,-122.4194")
  THE_3777491224194
}

enum Name {
  @JsonValue("Elevate FlowerApp Store")
  ELEVATE_FLOWER_APP_STORE
}

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "gender")
  Gender? gender;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "passwordChangedAt")
  DateTime? passwordChangedAt;
  @JsonKey(name: "resetCodeVerified")
  bool? resetCodeVerified;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
    this.resetCodeVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum Gender {
  @JsonValue("female")
  FEMALE,
  @JsonValue("male")
  MALE
}
