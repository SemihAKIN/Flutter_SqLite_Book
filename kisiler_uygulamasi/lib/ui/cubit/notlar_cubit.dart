import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entity/notlar_entity.dart';
import 'package:kisiler_uygulamasi/data/repo/notlardao_repository.dart';

class NotlarCubit extends Cubit<List<Notlar>> {
  NotlarCubit() : super(<Notlar>[]);

  var nrepo = NotlarDaoRepository();
  Future<void> notlariYukle() async {
    var liste = await nrepo.notlariYukle();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await nrepo.ara(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int not_id) async {
    await nrepo.sil(not_id);
    await notlariYukle();
  }
}
