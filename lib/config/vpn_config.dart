import 'dart:convert';

class VpnConfig {
  final String id;
  final String name;
  final String protocol;
  final String rawConfig;
  final DateTime createdAt;

  const VpnConfig({
    required this.id,
    required this.name,
    required this.protocol,
    required this.rawConfig,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'protocol': protocol,
    'rawConfig': rawConfig,
    'createdAt': createdAt.toIso8601String(),
  };

  factory VpnConfig.fromJson(Map<String, dynamic> json) => VpnConfig(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    protocol: json['protocol'] ?? 'VLESS',
    rawConfig: json['rawConfig'] ?? '',
    createdAt: json['createdAt'] != null 
        ? DateTime.parse(json['createdAt'])
        : null,
  );
}