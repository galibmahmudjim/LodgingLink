class Inventory {
  String? name;
  String? details;
  String? cost;
  String? timestamps;

  Inventory({this.name, this.details, this.cost, this.timestamps});

  Inventory.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    details = json['Details'];
    cost = json['Cost'];
    timestamps = json['Timestamps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Details'] = this.details;
    data['Cost'] = this.cost;
    data['Timestamps'] = this.timestamps;
    return data;
  }
}
