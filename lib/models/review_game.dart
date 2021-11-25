import 'package:json_annotation/json_annotation.dart';

part 'review_game.g.dart';

@JsonSerializable()
class ReviewGamePassageLink {
  @JsonKey(name: 'pid')
  String refPid;

  @JsonKey(name: 'link')
  String linkText;

  ReviewGamePassageLink(this.refPid, this.linkText);

  factory ReviewGamePassageLink.fromJson(Map<String, dynamic> json) =>
      _$ReviewGamePassageLinkFromJson(json);
}

@JsonSerializable()
class ReviewGamePassage {
  String pid;
  String name;

  @JsonKey(name: 'text')
  String textContent;

  @JsonKey(defaultValue: [])
  List<ReviewGamePassageLink> links;

  @JsonKey(defaultValue: null)
  bool? result;

  ReviewGamePassage(
      this.pid, this.name, this.textContent, this.links, this.result);

  factory ReviewGamePassage.fromJson(Map<String, dynamic> json) =>
      _$ReviewGamePassageFromJson(json);
}

@JsonSerializable()
class ReviewGame {
  String name;

  @JsonKey(name: 'startnode')
  String startNodePid;

  int lessonId;

  List<ReviewGamePassage> passages;

  ReviewGame(this.name, this.startNodePid, this.passages, this.lessonId);

  factory ReviewGame.fromJson(Map<String, dynamic> json) =>
      _$ReviewGameFromJson(json);

  ReviewGamePassage getStartPassage() {
    return getPassageById(startNodePid);
  }

  ReviewGamePassage getPassageById(String refPid) {
    return passages.firstWhere((pass) => pass.pid == refPid);
  }
}
