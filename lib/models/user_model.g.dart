// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      location: json['location'] as String?,
      techArea: json['techArea'] as String?,
      xId: json['xId'] as String?,
      instagramId: json['instagramId'] as String?,
      homepageLink: json['homepageLink'] as String?,
      deviceUuid: json['deviceUuid'] as String?,
      bleUserId: json['bleUserId'] as String?,
      lastCheersUserId: json['lastCheersUserId'] as String?,
      cheerUserIds: (json['cheerUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'location': instance.location,
      'techArea': instance.techArea,
      'xId': instance.xId,
      'instagramId': instance.instagramId,
      'homepageLink': instance.homepageLink,
      'deviceUuid': instance.deviceUuid,
      'bleUserId': instance.bleUserId,
      'lastCheersUserId': instance.lastCheersUserId,
      'cheerUserIds': instance.cheerUserIds,
    };
