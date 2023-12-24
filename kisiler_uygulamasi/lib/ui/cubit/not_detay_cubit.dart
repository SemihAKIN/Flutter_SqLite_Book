import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/notlardao_repository.dart';

class NotDetaySayfaCubit extends Cubit<void> {
  NotDetaySayfaCubit() : super(0);

  var nrepo = NotlarDaoRepository();
  Future<void> guncelleNot(
      int not_id, String not_konu, String not_icerik, String not_tarih) async {
    await nrepo.guncelleNot(not_id, not_konu, not_icerik, not_tarih);
  }
}
