import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_learner/api/model/country_model.dart';
import 'package:ruby_learner/api/service/country_api_service.dart';
import 'package:dio/dio.dart';
part 'country_list_bloc_state.dart';

class CountryListBlocCubit extends Cubit<CountryListBlocState> {
  CountryListBlocCubit() : super(CountryListBlocLoading());
  final CountryApiService _countryApiService = CountryApiService(Dio());

  void getCountryList() async {
    emit(CountryListBlocLoading());
    try {
      List<CountryModel> countryList = await _countryApiService.getAllCountry();
      emit(CountryListBlocSuccess(countryList));
    } catch (e) {
      emit(CountryListBlocFailed(e.toString()));
    }
  }
}
