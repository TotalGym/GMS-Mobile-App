abstract class Repo<T> {
  int totalCount = 0;
  int page = 0;
  int limit = 0;
  late Map<String, dynamic> next;
  List<T>? items;

  Repo();

  Repo.fromMap(Map<String, dynamic> map) {
    totalCount = map['totalCount'];
    page = map['page'];
    limit = map['limit'];
    next =
        map['next'] != null ? Map<String, dynamic>.from(map['next']) : {"": ""};
    items = map["items"];
  }

  Map<String, dynamic> toMap() {
    return {
      'totalCount': totalCount,
      'page': page,
      'limit': limit,
      'next': next,
      'items': items,
    };
  }
}
