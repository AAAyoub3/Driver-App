import 'package:json_annotation/json_annotation.dart';

part 'auth_credentials.g.dart';

@JsonSerializable()
class AuthCredentials {
  final String? auth_provider_x509_cert_url;
  final String? auth_uri;
  final String? client_email;
  final String? client_id;
  final String? client_x509_cert_url;
  final String? private_key;
  final String? private_key_id;
  final String? project_id;
  final String? token_uri;
  final String? type;
  final String? universe_domain;

  AuthCredentials({
    required this.auth_provider_x509_cert_url,
    required this.auth_uri,
    required this.client_email,
    required this.client_id,
    required this.client_x509_cert_url,
    required this.private_key,
    required this.private_key_id,
    required this.project_id,
    required this.token_uri,
    required this.type,
    required this.universe_domain,
  });

  factory AuthCredentials.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthCredentialsToJson(this);
}
