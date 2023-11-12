part of 'country_full_name_bloc_cubit.dart';

@immutable
abstract class CountryFullNameBlocState {}

class CountryFullNameBlocLoading extends CountryFullNameBlocState {}

class CountryFullNameBlocSuccess extends CountryFullNameBlocState {
  final List<CountryModel> countryList;

  CountryFullNameBlocSuccess(this.countryList);
}

class CountryFullNameBlocFailed extends CountryFullNameBlocState {
  final String error;

  CountryFullNameBlocFailed(this.error);
}
