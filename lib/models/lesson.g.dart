// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      json['id'] as int,
      json['contentLink'] as String,
      json['isPremiumContent'] as bool,
      $enumDecode(_$LessonStatusEnumMap, json['status']),
      json['completeDate'] == null
          ? null
          : DateTime.parse(json['completeDate'] as String),
      json['title'] as String,
      json['imagePath'] as String,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'contentLink': instance.contentLink,
      'isPremiumContent': instance.isPremiumContent,
      'status': _$LessonStatusEnumMap[instance.status],
      'completeDate': instance.completeDate?.toIso8601String(),
      'title': instance.title,
      'imagePath': instance.imagePath,
    };

const _$LessonStatusEnumMap = {
  LessonStatus.payLocked: 'payLocked',
  LessonStatus.locked: 'locked',
  LessonStatus.open: 'open',
  LessonStatus.completed: 'completed',
};
