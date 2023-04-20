import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MePageSate();

}

class MePageSate extends State<MePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ChartPage(),
      ),
    );
  }
}

class MyPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  MyPieChart(this.seriesList, {this.animate = true});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.inside,
          ),
        ],
      ),
    );
  }
}

class PieData {
  final String name;
  final double value;

  PieData(this.name, this.value);
}

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [
      new PieData('有违章\n70%', 70),
      new PieData('无违章\n30%', 30),
    ];

    var series = [
      new charts.Series(
        id: 'Pie Data',
        domainFn: (PieData data, _) => data.name,
        measureFn: (PieData data, _) => data.value,
        colorFn: (PieData data, _) => data.name.contains('有违章')
            ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.blue.shadeDefault,
        data: data,
        labelAccessorFn: (PieData row, _) => '${row.value.toInt()}%',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('饼状图'),
      ),
      body: Center(
        child: MyPieChart(series),
      ),
    );
  }
}

