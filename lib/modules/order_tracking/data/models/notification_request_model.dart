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
  final Map<String, String>? data;
  final NotificationModel notification;
  final AndroidConfigModel? android;

  MessageModel({
    required this.token,
    this.data,
    required this.notification,
    this.android,
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

@JsonSerializable()
class AndroidConfigModel {
  @JsonKey(name: 'direct_boot_ok')
  final bool directBootOk;

  AndroidConfigModel({
    required this.directBootOk,
  });

  factory AndroidConfigModel.fromJson(Map<String, dynamic> json) =>
      _$AndroidConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$AndroidConfigModelToJson(this);
}