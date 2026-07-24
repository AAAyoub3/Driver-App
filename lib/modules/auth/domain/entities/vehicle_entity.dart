import 'package:equatable/equatable.dart';

class VehicleEntity extends Equatable {
  final String? id;
  final String? type;

  const VehicleEntity({required this.id, required this.type});
  @override
  List<Object?> get props => [id,type];
}
