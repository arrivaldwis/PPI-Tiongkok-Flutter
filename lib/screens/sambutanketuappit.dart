import 'package:flutter/material.dart';

class Sambutanketuappit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget textSection = Container(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Salam Perhimpunan!\n',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              softWrap: true,
            ),
            Text(
              '''
            Puji  serta  syukur  kami  panjatkan  atas  kehadirat  Tuhan  yang  Maha  Esa. Karena berkat karuniaNya lah, kami dapat berkarya hingga saat ini. Selain itu,  atas  rahmat  Tuhan  YME,  kami  juga masih dapat diberikan kekuatan untuk tetap berhimpun di tanah rantau, Negeri dengan tembok raksasa ini.
            
            Melihat  jumlah  pelajar  Indonesia  yang  semakin  meningkat  dari  tahun ketahun dan melihat semangat para pelajar untuk berkarya di Negeri Panda,  maka  kami  Perhimpunan  Pelajar  Indonesia  (PPI)  Tiongkok mengajak teman-teman  semua  untuk  berkolaborasi  bersama  dalam wadah perhimpunan pelajar Indonesia di Tiongkok.
            
            Pepatah  Tiongkok  mengatakan  “Istirahat  bukan  berarti  berhenti,  Tetapi untuk menempuh perjalanan yang lebih jauh lagi”. “Xiu Xi Bu Shi Zou Deng Yu  Chang  De  Lu,  Er  Shi  Yao  Zou  Geng  Chang  De  Lu”.  Begitu  pula  dengan belajar di luar negeri, bukan berarti berhenti berkontribusi untuk negeri,  tetapi untuk memberikan yang lebih untuk Ibu Pertiwi.
            
            Oleh karena itu, PPI Tiongkok  hadir sebagai wadah bersama bagi  para putra-putri  bangsa  yang  sedang  menempuh ilmu di  negeri  panda  ini,  untuk berkolaborasi dan berkontribusi untuk negeri. Sehingga nantinya dapat saling menginpirasi.
            
            Akhir kata, kami berharap keterlibatan semua pihak yang ada dalam lingkup pelajar Indonesia di Tiongkok untuk bersama-sama mengawal organisasi ini agar dapat mengedankan nilai – nilai Tri Dharma Perguruan Tinggi serta menjadikan Perhimpunan ini sebagai wadah bersama untuk belajar dan berkarya tanpa memandang Suku, Etnis, Agama, Jenjang Pendidikan dan lain sebagainya yang dapat memecah persatuan kita sebagai bangsa Indonesia.
            
            Mari  berkolaborasi  untuk  berkontribusi untuk negeri dan menginspirasi satu sama lain.
            ''',
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
            Text(
              '\nWuhan, 6 Juni 2018',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              softWrap: true,
            ),
            Text(
              '\nFadlan Muzakki',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ],
        ));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text('Sambutan Ketua PPIT'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(32.0),
          children: <Widget>[
            Image.asset(
              'res/fadlanmuzakki.png',
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
