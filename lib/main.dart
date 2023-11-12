import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_learner/bloc/country_list_bloc_cubit.dart';
import 'package:ruby_learner/bloc/full_name/country_full_name_bloc_cubit.dart';
import 'package:ruby_learner/bloc/search/search_country_bloc.dart';
import 'package:ruby_learner/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountryListBlocCubit>(
          create: (BuildContext context) => CountryListBlocCubit(),
        ),
        BlocProvider<CountryFullNameBlocCubit>(
          create: (BuildContext context) => CountryFullNameBlocCubit(),
        ),
        BlocProvider<SearchCountryBloc>(
          create: (BuildContext context) => SearchCountryBloc(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
