import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/cubit/notlar_cubit.dart';

import 'anasayfa.dart';
import 'notlar.dart';

class BottomNavSayfa extends StatefulWidget {
  const BottomNavSayfa({Key? key}) : super(key: key);

  @override
  _BottomNavSayfaState createState() => _BottomNavSayfaState();
}

class _BottomNavSayfaState extends State<BottomNavSayfa> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Anasayfa(),
    const NotlarSayfa(),
  ];
  var language = "tr";
  bool aramaYapiliyorMu = false;
  final TextEditingController _aramaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[300],
        title: aramaYapiliyorMu
            ? TextField(
                style: const TextStyle(
                    fontFamily: 'Roboto', color: Colors.black, fontSize: 20),
                controller: _aramaController,
                decoration: InputDecoration(hintText: d!.search),
                onChanged: (aramaSonucu) {
                  if (_selectedIndex == 0) {
                    context.read<AnasayfaCubit>().ara(aramaSonucu);
                  } else {
                    context.read<NotlarCubit>().ara(aramaSonucu);
                  }
                },
              )
            : Text(
                _selectedIndex == 0 ? d!.persons : d!.notes,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.normal),
              ),
        actions: [
          if (!aramaYapiliyorMu)
            IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyorMu = true;
                });
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          if (aramaYapiliyorMu)
            IconButton(
              onPressed: () {
                setState(() {
                  aramaYapiliyorMu = false;
                  _aramaController.clear();

                  if (_selectedIndex == 0) {
                    context.read<AnasayfaCubit>().kisileriYukle();
                  } else {
                    context.read<NotlarCubit>().notlariYukle();
                  }
                });
              },
              icon: const Icon(
                Icons.clear_outlined,
                color: Colors.black,
              ),
            ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.red,
        color: Colors.blueGrey[400],
        shape: const CircularNotchedRectangle(),
        child: IconTheme(
          data: const IconThemeData(color: Colors.black),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                icon: const Icon(Icons.person_search_outlined),
              ),
              const Spacer(),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                icon: const Icon(Icons.note_add_outlined),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
