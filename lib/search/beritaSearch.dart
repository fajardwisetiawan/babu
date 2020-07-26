class Berita {
  int id;
  String berita;
 
  Berita({this.id, this.berita});
 
  factory Berita.fromJson(Map<String, dynamic> parsedJson) {
    return Berita(
      id: parsedJson["_id"],
      berita: parsedJson["judul"] as String,
    );
  }
}