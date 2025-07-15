import 'package:flutter/material.dart';

// 기차역 리스트를 보여주고 선택할 수 있는 화면
class StationListPage extends StatelessWidget {
  final List<String> stationList;
  final String title;
  final String? excludedStation;

  const StationListPage({
    super.key,
    required this.stationList,
    required this.title,
    this.excludedStation,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> filteredStationList = stationList
        .where((station) => station != excludedStation)
        .toList();

    return Scaffold(
      // Scaffold 배경색은 main.dart의 ThemeData에서 관리하므로 여기서 직접 지정하지 않습니다.
      appBar: AppBar(
        // ❶ 앱바 타이틀 글자에 별도의 스타일 지정 X (main.dart의 AppBarTheme이 적용됨)
        title: Text(title),
        centerTitle: true,
        // ❷ 뒤로가기 버튼: 별도로 선언하지 않고 AppBar에서 기본으로 나오는 버튼 사용 (자동으로 생성됨)
      ),
      body: ListView.builder(
        itemCount: filteredStationList.length,
        itemBuilder: (context, index) {
          final String currentStation = filteredStationList[index];
          return Container( // ❹ 기차역 이름 감싸고 있는 영역: Container로 감싸서 높이와 테두리 지정
            height: 50, // ❹ 높이: 50
            decoration: BoxDecoration(
              border: Border( // ❹ 테두리: 아래에만 Colors.grey[300]!
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1.0,
                ),
              ),
            ),
            child: ListTile(
              title: Text(
                currentStation,
                style: const TextStyle(
                  fontSize: 18.0, // ❸ 글자 크기: 18
                  fontWeight: FontWeight.bold, // ❸ 글자 두께: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.pop(context, currentStation); // 선택된 역을 이전 화면으로 반환
              },
            ),
          );
          // 변경: 기존의 Divider는 Container의 border로 대체되었으므로 제거합니다.
          // if (index < filteredStationList.length - 1)
          //   const Divider(height: 1, indent: 16, endIndent: 16,),
        },
      ),
    );
  }
}