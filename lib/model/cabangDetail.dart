import './cabang.dart';
import './cabangInformations.dart';

class cabangDetail {
  static final List<Cabang> regions = [
    const Cabang(
        id: "1",
        name: "Region Utara",
        image: "assets/img/utara.png",
        // daftarCabang: "PPIT Harbin\nPERMIT Beijing\nPPIT Tianjin\nPPIT Shijiazhuang\nPPIT Zhengzhou",
        daftarCabang: [
          const CabangInformations(
              id: "1",
              name: "PPIT Harbin",
              endpoint: "http://ppitiongkokharbin.org"),
          const CabangInformations(
              id: "2",
              name: "PERMIT Beijing",
              endpoint: "http://www.permitbeijing.com"),
          const CabangInformations(
              id: "3",
              name: "PPIT Tianjin",
              endpoint: "http://tianjin.ppitiongkok.org"),
          const CabangInformations(
              id: "4",
              name: "PPIT Shijiazhuang",
              endpoint: "http://ppitshijiazhuang.org"),
          const CabangInformations(
              id: "5",
              name: "PPIT Zhengzhou",
              endpoint: "http://zhengzhou.ppitiongkok.org"),
        ]),
    const Cabang(
        id: "2",
        name: "Region Timur",
        image: "assets/img/timur.png",
        // daftarCabang: "PPIT Hangzhou\nPPIT Ningbo\nPPIT Shanghai\nPPIT Wuxi",
        daftarCabang: [
          const CabangInformations(
              id: "1",
              name: "PPIT Hangzhou",
              endpoint: "http://ppihangzhou.org"),
          const CabangInformations(
              id: "2",
              name: "PERMIT Ningbo",
              endpoint: "http://permitningbo.org"),
          const CabangInformations(
              id: "3",
              name: "PERMIT Shanghai",
              endpoint: "http://permitshanghai.com"),
          const CabangInformations(
              id: "4",
              name: "PPIT Wuxi",
              endpoint: "http://ppitiongkokwuxi.org"),
        ]),
    const Cabang(
        id: "3",
        name: "Region Selatan",
        image: "assets/img/selatan.png",
        // daftarCabang: "PPIT Chongqing\nPPIT Guilin\nPPIT Hongkong\nPPIT Wuhan\nPPIT Xiamen",
        daftarCabang: [
          const CabangInformations(
              id: "1",
              name: "PPIT Chongqing",
              endpoint: "http://ppitchongqing.com"),
          const CabangInformations(
              id: "2",
              name: "PPIT Guilin",
              endpoint: "http://himignu-ppitguilin.com"),
          const CabangInformations(
              id: "3",
              name: "PPIT Hongkong",
              endpoint: "http://ppihongkong.org"),
          const CabangInformations(
              id: "4",
              name: "PPIT Wuhan",
              endpoint: "http://ppitiongkokwuhan.org/"),
          const CabangInformations(
              id: "5",
              name: "PPIT Xiamen",
              endpoint: "http://permicxiamen.weebly.com"),
        ]),
  ];

  static Cabang getPlanetById(id) {
    return regions.where((p) => p.id == id).first;
  }
}
