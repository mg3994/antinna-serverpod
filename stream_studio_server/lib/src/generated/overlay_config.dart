/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;

abstract class OverlayConfig
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OverlayConfig._({
    required this.id,
    required this.streamId,
    required this.title,
    required this.subtitle,
    required this.position,
    required this.isVisible,
    required this.backgroundColor,
    required this.textColor,
  });

  factory OverlayConfig({
    required String id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required bool isVisible,
    required String backgroundColor,
    required String textColor,
  }) = _OverlayConfigImpl;

  factory OverlayConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return OverlayConfig(
      id: jsonSerialization['id'] as String,
      streamId: jsonSerialization['streamId'] as String,
      title: jsonSerialization['title'] as String,
      subtitle: jsonSerialization['subtitle'] as String,
      position: jsonSerialization['position'] as String,
      isVisible: _i1.BoolJsonExtension.fromJson(jsonSerialization['isVisible']),
      backgroundColor: jsonSerialization['backgroundColor'] as String,
      textColor: jsonSerialization['textColor'] as String,
    );
  }

  String id;

  String streamId;

  String title;

  String subtitle;

  String position;

  bool isVisible;

  String backgroundColor;

  String textColor;

  /// Returns a shallow copy of this [OverlayConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OverlayConfig copyWith({
    String? id,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    bool? isVisible,
    String? backgroundColor,
    String? textColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OverlayConfig',
      'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'isVisible': isVisible,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OverlayConfig',
      'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'isVisible': isVisible,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OverlayConfigImpl extends OverlayConfig {
  _OverlayConfigImpl({
    required String id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required bool isVisible,
    required String backgroundColor,
    required String textColor,
  }) : super._(
         id: id,
         streamId: streamId,
         title: title,
         subtitle: subtitle,
         position: position,
         isVisible: isVisible,
         backgroundColor: backgroundColor,
         textColor: textColor,
       );

  /// Returns a shallow copy of this [OverlayConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OverlayConfig copyWith({
    String? id,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    bool? isVisible,
    String? backgroundColor,
    String? textColor,
  }) {
    return OverlayConfig(
      id: id ?? this.id,
      streamId: streamId ?? this.streamId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      position: position ?? this.position,
      isVisible: isVisible ?? this.isVisible,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
