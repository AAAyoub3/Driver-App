import 'package:json_annotation/json_annotation.dart';
part 'firebase_notification_model.g.dart';
@JsonSerializable()
class FirebaseNotificationModel {
  final String title;
  final String body;
  final bool isRead;
  final String createdAt;

  const FirebaseNotificationModel({
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory FirebaseNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$FirebaseNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseNotificationModelToJson(this);
}