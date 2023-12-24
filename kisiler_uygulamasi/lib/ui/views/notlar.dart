import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisiler_uygulamasi/data/entity/notlar_entity.dart';
import 'package:kisiler_uygulamasi/ui/cubit/notlar_cubit.dart';
import 'package:kisiler_uygulamasi/ui/views/not_detay.dart';
import 'package:kisiler_uygulamasi/ui/views/not_kayit.dart';

class NotlarSayfa extends StatefulWidget {
  const NotlarSayfa({Key? key}) : super(key: key);

  @override
  State<NotlarSayfa> createState() => _NotlarSayfaState();
}

class _NotlarSayfaState extends State<NotlarSayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<NotlarCubit>().notlariYukle();
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context);

    return Scaffold(
      body: BlocBuilder<NotlarCubit, List<Notlar>>(
        builder: (context, notlarListesi) {
          if (notlarListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: notlarListesi.length,
              itemBuilder: (context, indeks) {
                var not = notlarListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotDetaySayfa(
                          not: not,
                        ),
                      ),
                    ).then((value) {
                      context.read<NotlarCubit>().notlariYukle();
                    });
                  },
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  not.not_konu,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  not.not_icerik,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            not.not_tarih,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("${not.not_konu} ${d?.delete}"),
                                action: SnackBarAction(
                                  label: d?.yes ?? '',
                                  onPressed: () {
                                    context.read<NotlarCubit>().sil(not.not_id);
                                  },
                                ),
                              ));
                            },
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(d?.noNote ?? ''),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[300],
        tooltip: d?.create,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotKayitSayfa(),
            ),
          ).then((value) {
            context.read<NotlarCubit>().notlariYukle();
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
