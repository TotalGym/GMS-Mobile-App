abstract class Repo<T> {
  int totalCount = 0;
  int page = 0;
  int limit = 0;
  Map<String, dynamic>? next;
  List<T>? items;

  Repo();

  fromMap(Map map) {
    totalCount = map['totalCount'];
    page = map['page'];
    limit = map['limit'];
    next = map['next'] != null ? Map<String, dynamic>.from(map['next']) : null;
    items = map["items"];
  }

  update(Repo tempRepo) {
    totalCount = tempRepo.totalCount;
    page = tempRepo.page;
    limit = tempRepo.limit;
    next = tempRepo.next;
    items!.addAll(Iterable.castFrom(tempRepo.items!));
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
