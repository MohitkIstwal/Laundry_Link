class StaffServiceModel{
  final String ServiceName;
  final List<String> ItemList;

  StaffServiceModel({
    required this.ServiceName,
    required this.ItemList,
  });

  Map<String, dynamic> toMap() {
    return {
      'ServiceName': ServiceName,
      'ItemList': ItemList,
    };
  }
}