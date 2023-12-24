import 'package:bloc/bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/notlardao_repository.dart';

class NotlarKayitSayfaCubit extends Cubit<void> {
  NotlarKayitSayfaCubit() : super(0);

  var nrepo = NotlarDaoRepository();

  Future<void> kaydetNot(
      String not_konu, String not_icerik, String not_tarih) async {
    await nrepo.kaydetNot(not_konu, not_icerik, not_tarih);
  }
}
