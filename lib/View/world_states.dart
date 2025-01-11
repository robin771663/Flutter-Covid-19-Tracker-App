import 'package:covid_tracker/View/countries_List.dart';
import 'package:covid_tracker/model/world_states_model.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecordes(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return const Expanded(
                            flex: 1,
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .03),
                              child: PieChart(
                                dataMap: {
                                  "Total": double.parse(
                                      snapshot.data!.cases.toString()),
                                  "Recovered": double.parse(
                                      snapshot.data!.recovered.toString()),
                                  "Deaths": double.parse(
                                      snapshot.data!.deaths.toString()),
                                },
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: colorList,
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  ReausableRow(
                                      title: "Total",
                                      value: snapshot.data!.cases.toString()),
                                  ReausableRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString()),
                                  ReausableRow(
                                      title: "recovered",
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReausableRow(
                                      title: "active",
                                      value: snapshot.data!.active.toString()),
                                  ReausableRow(
                                      title: "critical",
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReausableRow(
                                      title: "todayDeaths",
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ReausableRow(
                                      title: "todayRecovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .05),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CountriesList()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text("Track Countris"),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReausableRow extends StatelessWidget {
  String title, value;
  ReausableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
