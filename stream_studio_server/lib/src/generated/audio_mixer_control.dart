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

abstract class AudioMixerControl
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AudioMixerControl._({
    required this.streamId,
    required this.micGain,
    required this.bgmVolume,
    required this.sfxVolume,
    required this.isMuted,
  });

  factory AudioMixerControl({
    required String streamId,
    required double micGain,
    required double bgmVolume,
    required double sfxVolume,
    required bool isMuted,
  }) = _AudioMixerControlImpl;

  factory AudioMixerControl.fromJson(Map<String, dynamic> jsonSerialization) {
    return AudioMixerControl(
      streamId: jsonSerialization['streamId'] as String,
      micGain: (jsonSerialization['micGain'] as num).toDouble(),
      bgmVolume: (jsonSerialization['bgmVolume'] as num).toDouble(),
      sfxVolume: (jsonSerialization['sfxVolume'] as num).toDouble(),
      isMuted: _i1.BoolJsonExtension.fromJson(jsonSerialization['isMuted']),
    );
  }

  String streamId;

  double micGain;

  double bgmVolume;

  double sfxVolume;

  bool isMuted;

  /// Returns a shallow copy of this [AudioMixerControl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AudioMixerControl copyWith({
    String? streamId,
    double? micGain,
    double? bgmVolume,
    double? sfxVolume,
    bool? isMuted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AudioMixerControl',
      'streamId': streamId,
      'micGain': micGain,
      'bgmVolume': bgmVolume,
      'sfxVolume': sfxVolume,
      'isMuted': isMuted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AudioMixerControl',
      'streamId': streamId,
      'micGain': micGain,
      'bgmVolume': bgmVolume,
      'sfxVolume': sfxVolume,
      'isMuted': isMuted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AudioMixerControlImpl extends AudioMixerControl {
  _AudioMixerControlImpl({
    required String streamId,
    required double micGain,
    required double bgmVolume,
    required double sfxVolume,
    required bool isMuted,
  }) : super._(
         streamId: streamId,
         micGain: micGain,
         bgmVolume: bgmVolume,
         sfxVolume: sfxVolume,
         isMuted: isMuted,
       );

  /// Returns a shallow copy of this [AudioMixerControl]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AudioMixerControl copyWith({
    String? streamId,
    double? micGain,
    double? bgmVolume,
    double? sfxVolume,
    bool? isMuted,
  }) {
    return AudioMixerControl(
      streamId: streamId ?? this.streamId,
      micGain: micGain ?? this.micGain,
      bgmVolume: bgmVolume ?? this.bgmVolume,
      sfxVolume: sfxVolume ?? this.sfxVolume,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}
