import 'package:equatable/equatable.dart';
import 'package:flowery/modules/auth/domain/entities/driver_entity.dart';

class ApplyResponseEntity extends Equatable {
  final String message;
  final DriverEntity driver;
  final String token;

  const ApplyResponseEntity({
    required this.message,
    required this.driver,
    required this.token,
  });

  @override
  List<Object?> get props => [message, driver, token];
}