import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_learner/api/model/country_model.dart';
import 'package:ruby_learner/bloc/full_name/country_full_name_bloc_cubit.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails({super.key, required this.countryName});
  final String countryName;

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CountryFullNameBlocCubit>(context).getCountry(widget.countryName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<CountryFullNameBlocCubit, CountryFullNameBlocState>(
          builder: (context, state) {
            if (state is CountryFullNameBlocSuccess) {
              CountryModel model = state.countryList[0];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(model.population.toString()),
                  Text(model.capital ?? ""),
                ],
              );
            } else if (state is CountryFullNameBlocFailed) {
              return Text(state.error.toString());
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
