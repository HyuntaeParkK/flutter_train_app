import 'package:flutter/material.dart';

// 기차역 리스트를 보여주고 선택할 수 있는 화면
class StationListPage extends StatelessWidget {
  final List<String> stationList;
  final String title;


  const StationListPage({super.key, required this.stationList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: stationList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(
                  stationList[index],
                  style: const TextStyle(fontSize: 18.0),
                ),
                onTap: () {
                  Navigator.pop(context, stationList[index]); // 선택된 역을 이전 화면으로 반환
                },
              ),
              if (index < stationList.length - 1) // 마지막 항목을 제외하고 구분선 추가
                const Divider(height: 1, indent: 16, endIndent: 16,), // 구분선 추가
            ],
          );
        },
      ),
    );
  }
}