import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:covid_19_tracker_app/View/country_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices= StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value)
                  {
                    setState(() {
                    });
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    focusColor: Colors.white,
                    hintText: 'Search with country name'
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                        future: statesServices.getCountriesListApi(),
                        builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {

                          if(!snapshot.hasData)
                            {
                              return  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: ListView.builder(
                                itemCount: 15,
                                                            itemBuilder: (context, index){
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade700,
                                      highlightColor: Colors.grey.shade100,
                                      child:  Column(
                                        children: [
                                          ListTile(
                                            leading:Container(height: 50,width: 50,color: Colors.white,),
                                            title: Container(height: 10,width: 89,color: Colors.white,),
                                            subtitle: Container(height: 10,width: 89,color: Colors.white,)
                                          )
                                        ],
                                      ));
                                }),
                              );
                            }
                          else
                            {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  String name= snapshot.data![index]['country'].toString();
                                  if(searchController.text.isEmpty)
                                    {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => CountryDetails(
                                                    image: snapshot.data![index]['countryInfo']['flag'],
                                                    name: snapshot.data![index]['country'],
                                                    totalCases: snapshot.data![index]['cases'] ?? 0,
                                                    totalDeaths: snapshot.data![index]['deaths'] ?? 0,
                                                    totalRecovered: snapshot.data![index]['recovered'] ?? 0,
                                                    active: snapshot.data![index]['active'] ?? 0,
                                                    critical: snapshot.data![index]['critical'] ?? 0,
                                                    todayRecovered: snapshot.data![index]['todayRecovered'] ?? 0,
                                                    test: snapshot.data![index]['tests'] ?? 0,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ListTile(
                                              leading: Image(
                                                height: 50,
                                                width: 50,
                                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                              ),
                                              title: Text(snapshot.data![index]['country'].toString()),
                                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  else if(name.toLowerCase().contains(searchController.text.toLowerCase())){

                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CountryDetails(
                                                  image: snapshot.data![index]['countryInfo']['flag'],
                                                  name: snapshot.data![index]['country'],
                                                  totalCases: snapshot.data![index]['cases'] ?? 0,
                                                  totalDeaths: snapshot.data![index]['deaths'] ?? 0,
                                                  totalRecovered: snapshot.data![index]['recovered'] ?? 0,
                                                  active: snapshot.data![index]['active'] ?? 0,
                                                  critical: snapshot.data![index]['critical'] ?? 0,
                                                  todayRecovered: snapshot.data![index]['todayRecovered'] ?? 0,
                                                  test: snapshot.data![index]['tests'] ?? 0,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ListTile(
                                            leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                            ),
                                            title: Text(snapshot.data![index]['country'].toString()),
                                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                  else
                                    {
                                      return Container();

                                    }
                                },);
                            }
                        },) )
              ],
            ),
          )),
    );
  }
}
