import 'package:kisiler_uygulamasi/data/entity/notlar_entity.dart';
import 'package:kisiler_uygulamasi/data/sqlite/veritabani_yardimcisi.dart';

class NotlarDaoRepository {
  Future<void> kaydetNot(
      String not_konu, String not_icerik, String not_tarih) async {
    var db = await VeritabaniYardimcisi.veritabanErisim();
    var yeniNot = Map<String, dynamic>();
    yeniNot["not_konu"] = not_konu;
    yeniNot["not_icerik"] = not_icerik;
    yeniNot["not_tarih"] = not_tarih;
    await db.insert("notlar", yeniNot);
  }

  Future<void> guncelleNot(
      int not_id, String not_konu, String not_icerik, String not_tarih) async {
    var db = await VeritabaniYardimcisi.veritabanErisim();
    var guncellenenNot = Map<String, dynamic>();
    guncellenenNot["not_konu"] = not_konu;
    guncellenenNot["not_icerik"] = not_icerik;
    guncellenenNot["not_tarih"] = not_tarih;
    await db.update("notlar", guncellenenNot,
        where: "not_id = ?", whereArgs: [not_id]);
  }

  Future<void> sil(int not_id) async {
    var db = await VeritabaniYardimcisi.veritabanErisim();
    await db.delete("notlar", where: "not_id = ?", whereArgs: [not_id]);
  }

  Future<List<Notlar>> notlariYukle() async {
    var db = await VeritabaniYardimcisi.veritabanErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM notlar");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Notlar(
        not_id: satir["not_id"],
        not_konu: satir["not_konu"],
        not_icerik: satir["not_icerik"],
        not_tarih: satir["not_tarih"],
      );
    });
  }

  Future<List<Notlar>> ara(aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabanErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM notlar WHERE not_konu like '%$aramaKelimesi%'");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Notlar(
        not_id: satir["not_id"],
        not_konu: satir["not_konu"],
        not_icerik: satir["not_icerik"],
        not_tarih: satir["not_tarih"],
      );
    });
  }
}
