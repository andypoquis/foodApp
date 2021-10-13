class Rubics {
  final String? label, id;
  Rubics({required this.label, this.id});
  Rubics.fromJson(Map<String, Object?> data)
      : this(label: data['label']! as String, id: data['id']! as String);
  Map<String, Object?> toJson() {
    return {'label': label};
  }
}
