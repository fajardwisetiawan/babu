import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:babu_apk/berandaPage/semuaPage.dart';

// ignore: must_be_immutable
class DetailBeritaPage extends StatefulWidget {
  List list;
  int index;
  DetailBeritaPage({this.index, this.list});
  @override
  _DetailBeritaPageState createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0.0,
        leading: new IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "BABU",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Text(
                      widget.list[widget.index]['judul'],
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            color: Colors.red,
                            width: 3.0,
                            height: 11.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Container(
                            child: Text(
                              widget.list[widget.index]['chanel'],
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${widget.list[widget.index]['tgl_post']}",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'OpenSans',
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: widget.list[widget.index]['img'] == null ? AssetImage("assets/images/0images.png") : NetworkImage(widget.list[widget.index]['img']),
                        // image: NetworkImage(widget.list[widget.index]['img']),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        widget.list[widget.index]['readmore'],
                        style:
                            TextStyle(fontSize: 16.0, fontFamily: 'OpenSans'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  // child: Text(
                  //   "Klik disini untuk mengunjungi halaman asli",
                  //   style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  // ),
                  child: new RichText(
                    text: new TextSpan(
                      text: 'Klik disini untuk mengunjungi halaman asli',
                      style: new TextStyle(color: Colors.blue[900], fontStyle: FontStyle.italic, decoration: TextDecoration.underline,),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              widget.list[widget.index]['url']);
                        },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300],
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.list[widget.index]['kategori'],
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: CircleAvatar(
                //           backgroundColor: Colors.grey,
                //           child: CircleAvatar(
                //             backgroundColor: Colors.white,
                //             radius: 30.0,
                //             child: Container(
                //               child: Icon(
                //                 Icons.favorite_border,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //           radius: 31.0,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: CircleAvatar(
                //           backgroundColor: Colors.grey,
                //           child: CircleAvatar(
                //             backgroundColor: Colors.white,
                //             radius: 30.0,
                //             child: Container(
                //               child: Icon(
                //                 Icons.bookmark_border,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //           radius: 31.0,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: CircleAvatar(
                //           backgroundColor: Colors.grey,
                //           child: CircleAvatar(
                //             backgroundColor: Colors.white,
                //             radius: 30.0,
                //             child: Container(
                //               child: Icon(
                //                 Icons.share,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ),
                //           radius: 31.0,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Text(
          //         "BERITA TERKAIT",
          //         style: TextStyle(
          //             fontSize: 16.0,
          //             fontFamily: 'OpenSans',
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Divider(
          //         color: Colors.black,
          //         height: 15,
          //         thickness: 1,
          //       ),
          //     ],
          //   ),
          // ),
          // BeritaList(
          //   gambar: 'assets/images/list6.jpg',
          //   text1: 'Kesehatan',
          //   text2: 'Ratusan Ahli Minta Masyarakat Waspada',
          //   text3: 'Kompas',
          //   text4:
          //       'Selama pandemi terjadi, organisasi kesehatan dunia justru dinilai lambat...',
          // ),
          // BeritaList(
          //   gambar: 'assets/images/list6.jpg',
          //   text1: 'Kesehatan',
          //   text2: 'Ratusan Ahli Minta Masyarakat Waspada',
          //   text3: 'Kompas',
          //   text4:
          //       'Selama pandemi terjadi, organisasi kesehatan dunia justru dinilai lambat...',
          // ),
          // BeritaList(
          //   gambar: 'assets/images/list6.jpg',
          //   text1: 'Kesehatan',
          //   text2: 'Ratusan Ahli Minta Masyarakat Waspada',
          //   text3: 'Kompas',
          //   text4:
          //       'Selama pandemi terjadi, organisasi kesehatan dunia justru dinilai lambat...',
          // ),
        ],
      ),
    );
  }
}
