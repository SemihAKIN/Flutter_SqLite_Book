import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisiler_uygulamasi/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({Key? key}) : super(key: key);

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(d!.create),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                //obscureText: true,
                controller: tfKisiAdi,
                decoration: InputDecoration(
                  hintText: d.personName,
                  border: const OutlineInputBorder(),
                  label: Text(d.personName),
                ),
              ),
              TextField(
                //obscureText: true,
                controller: tfKisiTel,
                decoration: InputDecoration(
                    hintText: d.personTel,
                    border: const OutlineInputBorder(),
                    label: Text(d.personTel)),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<KayitSayfaCubit>()
                      .kaydet(tfKisiAdi.text, tfKisiTel.text);
                  Navigator.of(context).pop();
                },
                child: Text(d.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
