class DropdownModel<T> {
  String? name;
  String? subtitle;
  String? value;
  T? dataModel;

  DropdownModel({String? name, this.subtitle, this.value, this.dataModel}) {
    // ✅ if name null hai to value assign ho jaye
    this.name = name ?? value;
  }
}
