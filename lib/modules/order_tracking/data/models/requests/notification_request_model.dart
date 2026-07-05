import 'package:json_annotation/json_annotation.dart';

part 'notification_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationRequestModel {
  final MessageModel message;

  NotificationRequestModel({
    required this.message,
  });

  factory NotificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageModel {
  final String token;
  final NotificationModel notification;


  MessageModel({
    required this.token,
    required this.notification,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

@JsonSerializable()
class NotificationModel {
  final String title;
  final String body;

  NotificationModel({
    required this.title,
    required this.body,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}