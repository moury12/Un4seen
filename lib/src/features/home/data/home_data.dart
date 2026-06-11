import '../home_export.dart';

// ── Model ─────────────────────────────────────────────────
class ItemModel extends ItemEntity {
  const ItemModel({required super.id, required super.title, super.subtitle});

  factory ItemModel.fromJson(Map<String, dynamic> j) => ItemModel(
    id: j['_id'] ?? j['id'] ?? '',
    title: j['title'] ?? '',
    subtitle: j['subtitle'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    if (subtitle != null) 'subtitle': subtitle,
  };
}

// ── DataSource ────────────────────────────────────────────
abstract class HomeRemoteDataSource {
  Future<List<ItemModel>> getItems();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<ItemModel>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 800));
    // TODO: replace with real API call
    return List.generate(
      10,
      (i) => ItemModel(
        id: '$i',
        title: 'Item ${i + 1}',
        subtitle: 'Subtitle for item ${i + 1}',
      ),
    );
  }
}

// ── Repository abstract ───────────────────────────────────
abstract class HomeRepository {
  Future<List<ItemEntity>> getItems();
}

// ── Repository impl ───────────────────────────────────────
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remote;
  HomeRepositoryImpl(this._remote);

  @override
  Future<List<ItemEntity>> getItems() => _remote.getItems();
}
