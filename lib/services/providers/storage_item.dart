class StorageItem {
  final String name;
  final bool isFolder;
  final String? path;

  StorageItem({
    required this.name,
    required this.isFolder,
    this.path,
  });
}
