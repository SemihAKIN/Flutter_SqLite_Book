import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/cubit/not_detay_cubit.dart';
import 'package:kisiler_uygulamasi/ui/cubit/not_kayit_cubit.dart';
import 'package:kisiler_uygulamasi/ui/cubit/notlar_cubit.dart';
import 'package:kisiler_uygulamasi/ui/views/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => KayitSayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => NotlarKayitSayfaCubit()),
        BlocProvider(create: (context) => NotDetaySayfaCubit()),
        BlocProvider(create: (context) => NotlarCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale("en", ""),
          Locale("tr", ""),
        ],
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const BottomNavSayfa(),
      ),
    );
  }
}
