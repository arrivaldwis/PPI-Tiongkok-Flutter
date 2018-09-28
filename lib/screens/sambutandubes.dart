import 'package:flutter/material.dart';

class Sambutandubes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget textSection = Container(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '\"Berikan aku 10 pemuda, maka akan aku guncang dunia\"',
              style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            Text(
              '\-Ir. Sukarno\n',
              style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.normal),
              textAlign: TextAlign.center,
              softWrap: true,
            ),

            Text(
              '''
              Pernyataan Presiden RI pertama itu menegaskan pentingnya peran generasi muda dalam mengisi kemerdekaan dan membangun Indonesia. Eksistensi dan kejayaan Negara Kesatuan RI di masa depan sepenuhnya berada dalam genggaman para pemuda Indonesia.
              
              Sebagai organisasi yang mewadahi dan mempersatukan para pemuda Indonesia yang menimba ilmu di Tiongkok, Perhimpunan Pelajar Indonesia Tiongkok (PPI) Tiongkok memiliki peran penting, tidak hanya dalam memberikan sumbangsih bagi pembangunan Indonesia, namun juga mengemban misi penting sebagai garda terdepan pengawal perdamaian dunia.
              
              Untuk itu, saya mengucapkan apresiasi yang setinggi-tingginya kepada seluruh pengurus PPI Tiongkok yang senantiasa berupaya dan bekerja sama dalam menghimpun para pelajar Indonesia di Tiongkok, untuk melakukan berbagai kegiatan positif, ikut mempromosikan Indonesia di Tiongkok, memperkokoh jembatan persahabatan antara kedua negara. Saya juga mendorong kepada seluruh pelajar dan pemuda Indonesia di Tiongkok, untuk terus berpartisipasi aktif dalam PPI Tiongkok, serta bekerja sama untuk mengukir masa depan Indonesia yang lebih cemerlang melalui berbagai prestasi dan inovasi.
              
              Generasi muda Indonesia adalah penerus bangsa dan merupakan Prime Mover Kemajuan Indonesia. Prestasi yang ditorehkan oleh para pelajar Indonesia hari ini, akan menentukan kemajuan masa depan Bangsa Indonesia kelak. Lanjutkan perjuangan para pendahulu kita dengan terus menimba ilmu, mengukir prestasi dan menjaga nama baik bangsa dan negara. Teruslah bermimpi, tetaplah optimis dan positif dalam menggapai cita-cita menuju kesuksesan.
              
              Semoga PPI Tiongkok senantiasa kokoh sebagai organisasi penggerak utama para pelajar Indonesia di Tiongkok untuk berkontribusi positif bagi pembangunan Indonesia.
              
              PPI Tiongkok Tetap Jaya!
              ''',
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.justify,
              softWrap: true,
            ),

            Text(
              '\nDJAUHARI ORATMANGUN',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              softWrap: true,
            ),

            Text(
              'Duta Besar Republik Indonesia\nUntuk Republik Rakyat Tiongkok\nMerangkap Mongolia',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              softWrap: true,
            ),

          ],
        )
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sambutan Duta Besar RI Pada Situs Resmi PPI Tiongkok'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(32.0),
          children: <Widget>[
            Image.asset(
                'res/djauharioratmangun.jpg',
              width: 100.0,
              height: 200.0,
              alignment: Alignment.center,
            ),
            textSection,
          ],
        ),
      ),
    );
  }
}
