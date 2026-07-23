import 'dart:io';
import 'package:equatable/equatable.dart';

class EditVehicleState extends Equatable {
  final bool isLoading;
  final bool isDone;
  final String? message;
  final String? selectedVehicleType;
  final File? licenseFile;

  const EditVehicleState({
    this.isLoading = false,
    this.isDone = false,
    this.message,
    this.selectedVehicleType,
    this.licenseFile,
  });

  EditVehicleState copyWith({
    final bool? isLoading,
    final bool? isDone,
    final String? message,
    final String? selectedVehicleType,
    final File? licenseFile,
  }) => EditVehicleState(
    isLoading: isLoading ?? this.isLoading,
    isDone: isDone ?? this.isDone,
    message: message ?? this.message,
    selectedVehicleType: selectedVehicleType ?? this.selectedVehicleType,
    licenseFile: licenseFile ?? this.licenseFile,
  );

  @override
  List<Object?> get props => [
    isLoading,
    isDone,
    message,
    selectedVehicleType,
    licenseFile,
  ];
}