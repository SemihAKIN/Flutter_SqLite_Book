// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:kisiler_uygulamasi/data/entity/notlar_entity.dart';
import 'package:kisiler_uygulamasi/ui/cubit/not_detay_cubit.dart';

class NotDetaySayfa extends StatefulWidget {
  final Notlar not;

  const NotDetaySayfa({Key? key, required this.not}) : super(key: key);

  @override
  State<NotDetaySayfa> createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {
  var tfNotKonu = TextEditingController();
  var tfNotIcerik = TextEditingController();
  late DateTime time;

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfNotKonu.text = not.not_konu;
    tfNotIcerik.text = not.not_icerik;
    time = DateTime.now();
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
                controller: tfNotKonu,
                decoration: InputDecoration(hintText: d.noteTitle),
              ),
              TextField(
                controller: tfNotIcerik,
                decoration: InputDecoration(hintText: d.noteContent),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<NotDetaySayfaCubit>().guncelleNot(
                        widget.not.not_id,
                        tfNotKonu.text,
                        tfNotIcerik.text,
                        DateFormat('dd/MM/yyyy').format(time).toString(),
                      );
                  Navigator.of(context).pop();
                },
                child: Text(d.update),
              )
            ],
          ),
        ),
      ),
    );
  }
}
