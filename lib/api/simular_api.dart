class SimularsApi {
  final int id;

  const SimularsApi({required this.id});

  static List<SimularsApi> fromArray(List<dynamic> array) {
    final List<SimularsApi> Simulars = [];
    for (var i = 0; i < array.length; i++) {
      Simulars.add(SimularsApi.fromJson(array[i]));
    }
    return Simulars;
  }

  factory SimularsApi.fromJson(Map<String, dynamic> json) {
    return SimularsApi(id: json['id']);
  }
}