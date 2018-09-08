import './cabang.dart';
class cabangDetail {

  static final List<Cabang> planets = [
    const Cabang(
      id: "1",
      name: "Region Utara",
      image: "assets/img/earth.png",
      daftarCabang: "PPIT Harbin\nPERMIT Beijing\nPPIT Tianjin\nPPIT Shijiazhuang\nPPIT Zhengzhou",
    ),
    const Cabang(
      id: "2",
      name: "Region Timur",
      image: "assets/img/neptune.png",
      daftarCabang: "PPIT Hangzhou\nPPIT Ningbo\nPPIT Shanghai\nPPIT Wuxi",
    ),
    const Cabang(
      id: "3",
      name: "Region Selatan",
      image: "assets/img/moon.png",
      daftarCabang: "PPIT Chongqing\nPPIT Guilin\nPPIT Hongkong\nPPIT Wuhan\nPPIT Xiamen",
    ),
  ];

  static Cabang getPlanetById(id) {
    return planets
        .where((p) => p.id == id)
        .first;
  }
}