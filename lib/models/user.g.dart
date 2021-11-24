// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['lessons'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      PremiumKey.fromJson(json['premiumKey'] as Map<String, dynamic>),
      Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
      version: json['version'] as String? ?? actualVersion,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'lessons': instance.lessons,
      'reviews': instance.reviews,
      'premiumKey': instance.premiumKey,
      'statistics': instance.statistics,
      'version': instance.version,
    };
