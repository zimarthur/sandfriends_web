class State {
  int idState;
  String name;
  String uf;

  State({
    required this.idState,
    required this.name,
    required this.uf,
  });

  factory State.fromJson(Map<String, dynamic> parsedJson) {
    return State(
      idState: parsedJson["IdState"],
      name: parsedJson["State"],
      uf: parsedJson["UF"],
    );
  }

  factory State.copyWith(State stateRef) {
    return State(
      idState: stateRef.idState,
      name: stateRef.name,
      uf: stateRef.uf,
    );
  }
}
