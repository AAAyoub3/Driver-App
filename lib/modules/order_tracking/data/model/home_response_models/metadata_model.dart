import 'package:json_annotation/json_annotation.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel {
  @JsonKey(name: 'currentPage') final int? currentPage;
  @JsonKey(name: 'totalPages') final int? totalPages;
  @JsonKey(name: 'totalItems') final int? totalItems;
  @JsonKey(name: 'limit') final int? limit;

  const MetadataModel({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) =>
      _$MetadataModelFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataModelToJson(this);
}
