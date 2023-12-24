// ignore_for_file: deprecated_member_use, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context);
    return Scaffold(
      body: BlocBuilder<AnasayfaCubit, List<Kisiler>>(
        builder: (context, kisilerListesi) {
          if (kisilerListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context, indeks) {
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfa(
                                  kisi: kisi,
                                ))).then((value) {
                      context.read<AnasayfaCubit>().kisileriYukle();
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
                                  kisi.kisi_ad,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  kisi.kisi_tel,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // AlertDialog'u oluştur
                                    return AlertDialog(
                                      title:
                                          Text("${kisi.kisi_ad} aransin mi?"),
                                      content: Text(kisi.kisi_tel),
                                      actions: [
                                        // AlertDialog'un altındaki butonlar
                                        TextButton(
                                          onPressed: () {
                                            // AlertDialog'u kapat
                                            Navigator.of(context).pop();
                                          },
                                          child:
                                              const Icon(Icons.cancel_outlined),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            aramaYap(kisi.kisi_tel);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                              Icons.check_box_outlined),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.call_outlined)),
                          IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("${kisi.kisi_ad} ${d?.delete}"),
                                  action: SnackBarAction(
                                      label: d!.yes,
                                      onPressed: () {
                                        context
                                            .read<AnasayfaCubit>()
                                            .sil(kisi.kisi_id);
                                      }),
                                ));
                              },
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: Colors.black54,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(d!.noNote),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[300],
        tooltip: d?.create,
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const KayitSayfa()))
              .then((value) {
            context.read<AnasayfaCubit>().kisileriYukle();
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void aramaYap(String telefonNumarasi) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(
          telefonNumarasi.replaceAll(RegExp(r'[^\d]+'), ''));
    } catch (e) {
      print('Telefon araması başlatılamadı: $telefonNumarasi');
    }
  }
}
