import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisiler_uygulamasi/ui/cubit/not_kayit_cubit.dart';

class NotKayitSayfa extends StatefulWidget {
  const NotKayitSayfa({Key? key}) : super(key: key);

  @override
  State<NotKayitSayfa> createState() => _NotKayitSayfaState();
}

class _NotKayitSayfaState extends State<NotKayitSayfa> {
  var tfNotKonu = TextEditingController();
  var tfNotIcerik = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Şu anki tarihi burada alın
    String time = DateTime.now().toString();
    DateTime now = DateTime.parse(time);
    var d = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(d!.noteCreatePage),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfNotKonu,
                decoration: InputDecoration(
                  hintText: d.noteTitle,
                  border: const OutlineInputBorder(),
                  label: Text(d.noteTitle),
                ),
              ),
              TextField(
                controller: tfNotIcerik,
                decoration: InputDecoration(
                    hintText: d.noteContent,
                    border: const OutlineInputBorder(),
                    label: Text(d.noteContent)),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<NotlarKayitSayfaCubit>().kaydetNot(
                        tfNotKonu.text,
                        tfNotIcerik.text,
                        "${now.day}/${now.month}/${now.year}");
                    Navigator.of(context).pop();
                  },
                  child: Text(d.save))
            ],
          ),
        ),
      ),
    );
  }
}
