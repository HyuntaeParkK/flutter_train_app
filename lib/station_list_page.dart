import 'package:flutter/material.dart';

// 기차역 리스트를 보여주고 선택할 수 있는 화면
class StationListPage extends StatelessWidget {
  final List<String> stationList;
  final String title;
  final String? excludedStation; // 변경: 제외할 역을 받을 매개변수 추가

  const StationListPage({
    super.key,
    required this.stationList,
    required this.title,
    this.excludedStation, // 변경: 제외할 역은 선택 사항이므로 nullable로 선언
  });

  @override
  Widget build(BuildContext context) {
    // 변경: 제외할 역을 필터링합니다.
    final List<String> filteredStationList = stationList
        .where((station) => station != excludedStation)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredStationList.length, // 변경: 필터링된 리스트의 길이를 사용
        itemBuilder: (context, index) {
          final String currentStation = filteredStationList[index]; // 변경: 필터링된 리스트의 역 사용
          return Column(
            children: [
              ListTile(
                title: Text(
                  currentStation, // 변경: 필터링된 리스트의 역 사용
                  style: const TextStyle(fontSize: 18.0),
                ),
                onTap: () {
                  Navigator.pop(context, currentStation); // 선택된 역을 이전 화면으로 반환
                },
              ),
              if (index < filteredStationList.length - 1) // 변경: 필터링된 리스트의 길이를 사용
                const Divider(height: 1, indent: 16, endIndent: 16,),
            ],
          );
        },
      ),
    );
  }
}