// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  Kisiler kisi;

  DetaySayfa({super.key, required this.kisi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(d!.detailPage),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(hintText: d.personName),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(hintText: d.personTel),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<DetaySayfaCubit>().guncelle(
                      widget.kisi.kisi_id, tfKisiAdi.text, tfKisiTel.text);
                  Navigator.of(context).pop();
                },
                child: Text(d.update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
