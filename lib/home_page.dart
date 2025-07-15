import 'package:flutter/material.dart';
import 'package:flutter_train_app/station_list_page.dart'; // StationListPage 임포트
import 'package:flutter_train_app/seat_page.dart';       // SeatPage 임포트

// 출발역, 도착역을 선택할 수 있는 초기 화면
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _departureStation; // 출발역 선택 값
  String? _arrivalStation; // 도착역 선택 값

  // 기차역 리스트
  final List<String> _stationList = const [
    "수서", "동탄", "평택지제", "천안아산", "오송", "대전", "김천구미", "동대구", "경주", "울산", "부산"
  ];

  Future<void> _selectStation(BuildContext context, bool isDeparture) async {
    final String? selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StationListPage(
          stationList: _stationList,
          title: isDeparture ? '출발역' : '도착역'),
      ),
    );

    if (selectedStation != null) {
      setState(() {
        if (isDeparture) {
          _departureStation = selectedStation;
        } else {
          _arrivalStation = selectedStation;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 배경색을 이미지와 유사하게 설정
      appBar: AppBar(
        title: const Text('기차 예매'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector( // 출발역 선택 가능하도록 GestureDetector 추가
                            onTap: () => _selectStation(context, true),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  '출발역',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  _departureStation ?? '선택', // 선택된 역이 있으면 표시, 없으면 '선택'
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80.0,
                          width: 1.0,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: GestureDetector( // 도착역 선택 가능하도록 GestureDetector 추가
                            onTap: () => _selectStation(context, false),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  '도착역',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  _arrivalStation ?? '선택', // 선택된 역이 있으면 표시, 없으면 '선택'
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  // 출발역과 도착역이 모두 선택되었는지 확인
                  if (_departureStation != null && _arrivalStation != null) {
                    // 좌석 선택 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SeatPage()),
                    );
                  } else {
                    // 사용자에게 역을 선택하라는 메시지 표시 (예: 스낵바)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('출발역과 도착역을 모두 선택해주세요.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '좌석 선택',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}