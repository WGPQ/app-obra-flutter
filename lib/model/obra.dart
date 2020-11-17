class Obra {
  String id;
  String nombre;
  double lat;
  double lon;
  String fecha_ini;
  String fecha_fin;
  String marcador;
  String descripcion;
  String otroDato;
  Obra(
      {this.id,
      this.nombre,
      this.lat,
      this.lon,
      this.fecha_ini,
      this.fecha_fin,
      this.marcador,
      this.descripcion,
      this.otroDato});
//new DateTime.fromMillisecondsSinceEpoch
  Obra.fromFirestore(Map firestore, String id)
      : id = firestore['id'] ?? '',
        nombre = firestore['nombre'] ?? '',
        lat = firestore['lat'] ?? '',
        lon = firestore['lon'] ?? '',
        fecha_ini = firestore['fecha_ini'] ?? '',
        fecha_fin = firestore['fecha_fin'] ?? '',
        marcador = firestore['marcador'] ?? '',
        descripcion = firestore['descripcion'] ?? '',
        otroDato = firestore['otroDato'] ?? '';

  factory Obra.formMap(dynamic firestore) => Obra(
      id: firestore['id'],
      nombre: firestore['nombre'],
      lat: firestore['lat'],
      lon: firestore['lon'],
      fecha_ini: firestore['fecha_ini'],
      fecha_fin: firestore['fecha_fin'],
      marcador: firestore['marcador'],
      descripcion: firestore['descripcion'],
      otroDato: firestore['otroDato']);
}
