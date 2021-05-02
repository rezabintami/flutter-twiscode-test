import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twistcode_test/bloc/blocs.dart';
import 'package:twistcode_test/cubit/cubits.dart';

import 'ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BLOC PROVIDER
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
          // CUBIT PROVIDER
          BlocProvider(create: (_) => ProductCubit()),
          BlocProvider(create: (_) => CartCubit()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themestate) => MaterialApp(
            theme: themestate.themeData,
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          ),
        ));
  }
}
