import 'dart:convert';
import 'package:http/http.dart' as http;

// Content contentFromJson(String str) => Content.fromJson(json.decode(str));

// String contentToJson(Content data) => json.encode(data.toJson());

// class Content {
//   List<ContentElement> content;

//   Content({
//     this.content,
//   });

//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//         content: List<ContentElement>.from(
//             json["data"].map((x) => ContentElement.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(content.map((x) => x.toJson())),
//       };
// }

// class ContentElement {
//   String nomorAccount;
//   String namaPegawai;
//   String statusAccount;
//   String jenisAccount;
//   String produkAccount;
//   String mataUang;
//   String saldoEfektif;
//   String saldoBuku;

//   ContentElement({
//     this.nomorAccount,
//     this.namaPegawai,
//     this.statusAccount,
//     this.jenisAccount,
//     this.produkAccount,
//     this.mataUang,
//     this.saldoEfektif,
//     this.saldoBuku,
//   });

//   factory ContentElement.fromJson(Map<String, dynamic> json) => ContentElement(
//         nomorAccount: json["_id"],
//         namaPegawai: json["judul"],
//         statusAccount: json["url"],
//         jenisAccount: json["tgl_post"],
//         produkAccount: json["img"],
//         mataUang: json["kategori"],
//         saldoEfektif: json["readmore"],
//         saldoBuku: json["chanel"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": nomorAccount,
//         "judul": namaPegawai,
//         "url": statusAccount,
//         "tgl_post": jenisAccount,
//         "img": produkAccount,
//         "kategori": mataUang,
//         "readmore": saldoEfektif,
//         "chanel": saldoBuku,
//       };
// }

class Data {
  String id;
  String judul;
  String url;
  String tglPost;
  String img;
  String kategori;
  String readmore;
  String chanel;

  Data({
    this.id,
    this.judul,
    this.url,
    this.tglPost,
    this.img,
    this.kategori,
    this.readmore,
    this.chanel
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data (
      id: json['_id'],
      judul: json['judul'],
      url: json['url'],
      tglPost: json['tgl_post'],
      img: json['img'],
      kategori: json['kategori'],
      readmore:json['readmore'],
      chanel:json['chanel']
  );
}
}

class PostResult {
  List<Data> data;

  PostResult({
    this.data
  });

  factory PostResult.createPostResult(Map<String, dynamic> object) {
    return PostResult(
      data: (object['data'] as List)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static Future<PostResult> connectToAPI(String judul) async {
      String apiURL = "http://103.112.162.79:3000/search";
      var apiResult = await http.post(apiURL, body: {"judul": judul});
      var jsonObject = json.decode(apiResult.body);
      return PostResult.createPostResult(jsonObject);
    }
}