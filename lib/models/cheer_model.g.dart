// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheerImpl _$$CheerImplFromJson(Map<String, dynamic> json) => _$CheerImpl(
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CheerImplToJson(_$CheerImpl instance) =>
    <String, dynamic>{
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'keywords': instance.keywords,
    };
