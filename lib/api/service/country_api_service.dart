import 'package:retrofit/http.dart';
import 'package:ruby_learner/const/api_const.dart';
import 'package:dio/dio.dart';

import '../model/country_model.dart';

part 'country_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class CountryApiService {
  factory CountryApiService(Dio dio) => _CountryApiService(dio);

  @GET(ApiConst.all)
  Future<List<CountryModel>> getAllCountry();

  @GET("${ApiConst.search}{name}")
  Future<List<CountryModel>> searchCountry(
      {@Path('name') required String name});

  @GET("${ApiConst.search}{name}?fullText=true")
  Future<List<CountryModel>> getCountry(@Path('name') String name);
}
