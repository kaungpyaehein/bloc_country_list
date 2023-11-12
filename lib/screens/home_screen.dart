import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_learner/api/model/country_model.dart';
import 'package:ruby_learner/bloc/country_list_bloc_cubit.dart';
import 'package:ruby_learner/bloc/search/search_country_bloc.dart';
import 'package:ruby_learner/screens/country_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CountryListBlocCubit>(context).getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    SearchCountryBloc searchCountryBloc =
        BlocProvider.of<SearchCountryBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SearchAnchor(
            isFullScreen: false,
            builder: (context, controller) {

              controller.addListener(() {
                if (controller.text.isNotEmpty) {
                  searchCountryBloc.add(SearchCountry(controller.text));
                  print(controller.text);
                }
              });

              return SearchBar(

                onTap: () {
                  controller.openView();
                },
                hintText: "Search",
              );
            },
            suggestionsBuilder: (context, controller) {
              return [
                BlocBuilder<SearchCountryBloc, SearchCountryState>(
                  builder: (context, state) {
                    if (state is SearchCountrySuccess) {
                      List<CountryModel> countryList = state.countryList;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: countryList.length,
                          itemBuilder: (context, index) {
                            CountryModel countryModel = countryList[index];
                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                  "${countryModel.flags?.png}",
                                  width: 100,
                                ),
                                title: Text(countryModel.name ?? ''),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is SearchCountryLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: Text("Empty"),
                    );
                  },
                )
              ];
            },
          ),
          Expanded(
            child: BlocBuilder<CountryListBlocCubit, CountryListBlocState>(
              builder: (context, state) {
                if (state is CountryListBlocSuccess) {
                  List<CountryModel> countryList = state.countryList;

                  return ListView.builder(
                    itemCount: countryList.length,
                    itemBuilder: (context, index) {
                      CountryModel countryModel = countryList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountryDetails(
                                  countryName: countryModel.name ?? "",
                                ),
                              ));
                        },
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    "${countryModel.flags?.png}",
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Text(
                                        countryModel.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Text(
                                          "Capital city : ${countryModel.capital}"),
                                      Text("Region : ${countryModel.region}"),
                                      Text(
                                          "Subregion : ${countryModel.subregion}")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is CountryListBlocFailed) {
                  return const Center(child: Text("Something is wrong"));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
