import 'dart:math';

import 'package:cryptotrade/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AssetPriceChart extends StatelessWidget {
  final double index;
  final List<FlSpot>? data;

  const AssetPriceChart({
    required this.index,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      lineChartData,
      // swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get lineChartData => LineChartData(
        lineTouchData: lineTouchData, // Customize touch points
        gridData: gridData, // Customize grid
        titlesData: titlesData, // Customize axis labels
        borderData: borderData, // Customize border
        lineBarsData: [
          lineChartBarData,
        ],
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: AppColors.surfaceShape, // Ensure correct parameter
            ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(show: false);

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: false,
        // colors: [
        //   this.index >= 0 ? AppColors.greenMain : AppColors.redMain,
        // ],
        show: true,
        barWidth: 2,
        dotData: FlDotData(show: false),
        spots: data ?? [], // Ensure data is non-null
        belowBarData: BarAreaData(
          show: true,
          // colors: [
          //   this.index >= 0 ? AppColors.surfaceBG : AppColors.surfaceBG,
          // ],
        ),
      );

  static List<FlSpot> generateSampleData() {
    final List<FlSpot> result = [];
    final numPoints = 35;
    final maxY = 6;

    double prev = 0;

    for (int i = 0; i < numPoints; i++) {
      final next = prev +
          Random().nextInt(3).toDouble() % -1000 * i +
          Random().nextDouble() * maxY / 10;

      prev = next;

      result.add(
        FlSpot(i.toDouble(), next),
      );
    }

    return result;
  }
}
