import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';

class PieWidget extends StatelessWidget {
  const PieWidget({Key? key}) : super(key: key);
  static const routeName = '/pie-widget-screen';
  final dataMap = const <String, double>{
    'Crypto': 33,
    'Cash': 20,
    'Stocks': 13,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
          width: 190,
          height: 190,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green[400],
          ),
        ),
        PieChart(
          chartRadius: 200,
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.green[100]!,
          legendOptions: LegendOptions(showLegends: false),
          chartValuesOptions: ChartValuesOptions(showChartValuesOutside: false),
          colorList: [
            Colors.green[300]!,
            Colors.green[700]!,
            Colors.green[900]!
          ],
          totalValue: 100,
        ),
        Text('86',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white))
      ]),
    );
  }
}
