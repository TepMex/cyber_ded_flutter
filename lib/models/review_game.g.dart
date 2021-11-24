// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewGamePassageLink _$ReviewGamePassageLinkFromJson(
        Map<String, dynamic> json) =>
    ReviewGamePassageLink(
      json['pid'] as String,
      json['link'] as String,
    );

Map<String, dynamic> _$ReviewGamePassageLinkToJson(
        ReviewGamePassageLink instance) =>
    <String, dynamic>{
      'pid': instance.refPid,
      'link': instance.linkText,
    };

ReviewGamePassage _$ReviewGamePassageFromJson(Map<String, dynamic> json) =>
    ReviewGamePassage(
      json['pid'] as String,
      json['name'] as String,
      json['text'] as String,
      (json['links'] as List<dynamic>?)
              ?.map((e) =>
                  ReviewGamePassageLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      json['result'] as bool?,
    );

Map<String, dynamic> _$ReviewGamePassageToJson(ReviewGamePassage instance) =>
    <String, dynamic>{
      'pid': instance.pid,
      'name': instance.name,
      'text': instance.textContent,
      'links': instance.links,
      'result': instance.result,
    };

ReviewGame _$ReviewGameFromJson(Map<String, dynamic> json) => ReviewGame(
      json['name'] as String,
      json['startnode'] as String,
      (json['passages'] as List<dynamic>)
          .map((e) => ReviewGamePassage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewGameToJson(ReviewGame instance) =>
    <String, dynamic>{
      'name': instance.name,
      'startnode': instance.startNodePid,
      'passages': instance.passages,
    };
