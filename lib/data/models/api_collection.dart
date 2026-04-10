/// Wraps a Hydra collection response with hydra:member and hydra:totalItems.
class ApiCollection<T> {
  const ApiCollection({
    required this.members,
    required this.totalItems,
  });

  final List<T> members;
  final int totalItems;

  factory ApiCollection.fromJson(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (json is List) {
      final members = json
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiCollection(members: members, totalItems: members.length);
    }
    final map = json as Map<String, dynamic>;
    final rawMembers = map['hydra:member'] as List<dynamic>? ?? [];
    return ApiCollection(
      members: rawMembers
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList(),
      totalItems: map['hydra:totalItems'] as int? ?? rawMembers.length,
    );
  }
}
