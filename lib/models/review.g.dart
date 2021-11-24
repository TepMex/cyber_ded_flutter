// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['id'] as int,
      json['lessonId'] as int,
      json['contentLink'] as String,
      $enumDecode(_$SRSStatusEnumMap, json['status']),
      json['nextReviewDate'] == null
          ? null
          : DateTime.parse(json['nextReviewDate'] as String),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'contentLink': instance.contentLink,
      'status': _$SRSStatusEnumMap[instance.status],
      'nextReviewDate': instance.nextReviewDate?.toIso8601String(),
    };

const _$SRSStatusEnumMap = {
  SRSStatus.locked: 'locked',
  SRSStatus.unlocked: 'unlocked',
  SRSStatus.apprentice: 'apprentice',
  SRSStatus.guru: 'guru',
  SRSStatus.enlightened: 'enlightened',
  SRSStatus.burned: 'burned',
};
