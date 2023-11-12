import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ruby_learner/api/model/country_model.dart';
import 'package:ruby_learner/api/service/country_api_service.dart';
import 'package:dio/dio.dart';
part 'country_full_name_bloc_state.dart';

class CountryFullNameBlocCubit extends Cubit<CountryFullNameBlocState> {
  final CountryApiService _countryApiService = CountryApiService(Dio());

  CountryFullNameBlocCubit() : super(CountryFullNameBlocLoading());

  void getCountry(String name) async {
    emit(CountryFullNameBlocLoading());

    try {
      List<CountryModel> countryList =
          await _countryApiService.getCountry(name);
      emit(CountryFullNameBlocSuccess(countryList));
    } catch (e) {
      emit(CountryFullNameBlocFailed(e.toString()));
    }
  }
}
