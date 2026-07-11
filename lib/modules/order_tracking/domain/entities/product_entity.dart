import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final int? price;

  const ProductEntity({this.id, this.price});

  @override
  List<Object?> get props => [id, price];
}
