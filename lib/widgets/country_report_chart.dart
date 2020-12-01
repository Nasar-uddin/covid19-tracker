import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as sfc;
import 'package:trackc19/models/time_series.dart';
class CountryReportChart extends StatelessWidget {
  final deaths;
  final recovered;
  CountryReportChart({
    @required this.deaths, 
    @required this.recovered
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: sfc.SfCartesianChart(
        legend: sfc.Legend(
          isVisible: true
        ),
        tooltipBehavior: sfc.TooltipBehavior(enable: true),
        primaryXAxis: sfc.DateTimeAxis(
          majorGridLines: sfc.MajorGridLines(width: 0)
        ),
        primaryYAxis: sfc.NumericAxis(
          labelFormat: '{value}k',
          majorGridLines: sfc.MajorGridLines(
            width: 0.5,
          )
        ),
        series: <sfc.ChartSeries>[
          new sfc.LineSeries<TimeSeries, DateTime>(
            name: 'Recoverd',
            color: Colors.blue,
            dataSource: recovered,
            xValueMapper: (TimeSeries ts,_)=> ts.date,
            yValueMapper: (TimeSeries ts,_)=> ts.number/1000,
            markerSettings: sfc.MarkerSettings(
              isVisible: true,
            )
          ),
          new sfc.LineSeries<TimeSeries, DateTime>(
            name: 'Deaths',
            color: Colors.red,
            dataSource: deaths,
            xValueMapper: (TimeSeries ts,_)=> ts.date,
            yValueMapper: (TimeSeries ts,_)=> ts.number/1000,
            markerSettings: sfc.MarkerSettings(
              isVisible: true,
            )
          ),
        ],
      )
    );
  }
}

