import 'dart:async';
import 'dart:convert';

import 'package:covid_19_tracker_app/Model/WorldStatesModel.dart';
import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

import 'countries_list.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin{

  // late final AnimationController _controller = AnimationController(
  //     duration: const Duration(seconds: 3),
  //     vsync: this)..repeat();
  //
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(Duration(seconds: 5), () => Navigator.push(context,MaterialPageRoute(builder: (context) => WorldStats(),)),);
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controller.dispose();
  // }

  final colorList = <Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                FutureBuilder<WorldStatesModel>(
                    future: statesServices.getWorldStatesApi(),
                    builder: (context, snapshot) {
                     if(!snapshot.hasData)
                       {
                         return const Expanded(
                             flex: 1,
                             child: SpinKitFadingCircle(
                               color: Colors.white,
                               size: 50,
                               // controller: _controller,
                         ));
                       }
                     else
                       {
                         return Column(
                           children: [
                             PieChart(
                               dataMap: {
                                 "Total" : snapshot.data!.cases!.toDouble(),
                                 "Recovered" : snapshot.data!.recovered!.toDouble(),
                                 "Deaths" : snapshot.data!.deaths!.toDouble()
                               },
                               chartValuesOptions: const ChartValuesOptions(
                                 showChartValuesInPercentage: true
                               ),
                               animationDuration: Duration(milliseconds: 1200),
                               chartType: ChartType.ring,
                               colorList: colorList,
                               chartRadius: MediaQuery.of(context).size.width / 3.2,
                               legendOptions: const LegendOptions(
                                   legendPosition: LegendPosition.left
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06  ),
                               child: Card(
                                 child: Padding(
                                   padding: const EdgeInsets.only(top: 18.0),
                                   child: Column(
                                     children: [
                                       reuseableRow(title: "Total", value: snapshot.data!.cases!.toString()),
                                       reuseableRow(title: "Deaths", value: snapshot.data!.deaths!.toString()),
                                       reuseableRow(title: "Recovered", value: snapshot.data!.recovered!.toString()),
                                       reuseableRow(title: "Active", value: snapshot.data!.active!.toString()),
                                       reuseableRow(title: "Critical", value: snapshot.data!.critical!.toString()),
                                       reuseableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths!.toString()),
                                       reuseableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered!.toString())
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesList(),));
                               },
                               child: Container(
                                 height: 50,
                                 decoration: BoxDecoration(
                                     color: Color(0xff1aa260),
                                     borderRadius: BorderRadius.circular(12)
                                 ),
                                 child: Center(child: Text('Track Countries')),
                               ),
                             )
                           ],
                         );
                       }
                    },),


              ],
            ),
          ) ),
    );
  }
}

class reuseableRow extends StatelessWidget {
  String title, value;
  reuseableRow({super.key,required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12,top: 10,bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}
