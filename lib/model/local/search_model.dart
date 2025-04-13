import 'package:hive/hive.dart';


//part 'searchModel_box.g.dart';

@HiveType(typeId: 1)
class SearchModelBox extends HiveObject {
  @HiveField(0)
  String? searchList;

  SearchModelBox({
    this.searchList,
  });

  factory SearchModelBox.fromJson(Map<String, dynamic> json) {
    return SearchModelBox(
      searchList: json['searchList'] ?? [],
    );
  }

}

