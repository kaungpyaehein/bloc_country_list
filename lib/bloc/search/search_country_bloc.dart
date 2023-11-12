import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ruby_learner/api/model/country_model.dart';
import 'package:ruby_learner/api/service/country_api_service.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
part 'search_country_event.dart';
part 'search_country_state.dart';

class SearchCountryBloc extends Bloc<SearchCountryEvent, SearchCountryState> {
  final CountryApiService countryApiService =
      CountryApiService(Dio()..interceptors.add(PrettyDioLogger()));
  SearchCountryBloc() : super(SearchCountryInitial()) {
    on<SearchCountryEvent>(
      (event, emit) async {
        if (event is SearchCountry) {
          String name = event.name;
          if (name.isEmpty) {
            emit(SearchCountryInitial())} else {
            emit(SearchCountryLoading());
            try {
              List<CountryModel> countryList =
                  await countryApiService.searchCountry(name: name);
              emit(SearchCountrySuccess(countryList));
            } catch (e) {
              emit(SearchCountryFailed(e.toString()));
            }
          }
        }
      },
      transformer: (event, mapper) {
        return event
            .debounceTime(Duration(milliseconds: 500))
            .asyncExpand(mapper);
      },
    );
  }
}
