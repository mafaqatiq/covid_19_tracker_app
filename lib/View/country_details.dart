import 'package:covid_19_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  String image, name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  CountryDetails({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
});

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.2,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06  ),
                    child: Card(
                      elevation: 1.2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height*.05,
                            ),
                            reuseableRow(title: "Total Cases", value: widget.totalCases.toString()),
                            reuseableRow(title: "Total Deaths", value: widget.totalDeaths.toString()),
                            reuseableRow(title: "Recovered", value: widget.totalRecovered.toString()),
                            reuseableRow(title: "Active", value: widget.active.toString()),
                            reuseableRow(title: "Critical", value: widget.critical.toString()),
                            reuseableRow(title: "Today Deaths", value: widget.totalDeaths.toString()),
                            reuseableRow(title: "Today Recovered", value: widget.totalRecovered.toString())
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
