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
  int _numberOfPassengers = 1; // 변경: 추가 - 예약할 인원수 (기본값 1명)

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
          title: isDeparture ? '출발역' : '도착역',
          excludedStation: isDeparture ? _arrivalStation : _departureStation,
        ),
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

  // 변경: 인원수 증가 함수 (스낵바에 X 버튼 추가)
  void _incrementPassengers() {
    setState(() {
      if (_numberOfPassengers < 4) { // 최대 4명
        _numberOfPassengers++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar( // 변경: SnackBarAction 추가
            content: const Text('최대 4명까지 예약 가능합니다.'),
            action: SnackBarAction(
              label: 'X',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    });
  }

  // 변경: 인원수 감소 함수 (스낵바에 X 버튼 추가)
  void _decrementPassengers() {
    setState(() {
      if (_numberOfPassengers > 1) { // 최소 1명
        _numberOfPassengers--;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar( // 변경: SnackBarAction 추가
            content: const Text('최소 1명 이상 예약해야 합니다.'),
            action: SnackBarAction(
              label: 'X',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStation(context, true),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  '출발역',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  _departureStation ?? '선택',
                                  style: const TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          width: 2.0,
                          color: Colors.grey[400],
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectStation(context, false),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  '도착역',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  _arrivalStation ?? '선택',
                                  style: const TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
              const SizedBox(height: 30.0),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: _numberOfPassengers == 1 ? Colors.grey : Colors.deepPurple),
                      onPressed: _decrementPassengers,
                      iconSize: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$_numberOfPassengers 명',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: _numberOfPassengers == 4 ? Colors.grey : Colors.deepPurple),
                      onPressed: _incrementPassengers,
                      iconSize: 30,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // 변경: 스낵바가 표시되어 있다면 즉시 숨깁니다.
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    if (_departureStation != null && _arrivalStation != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatPage(
                            departureStation: _departureStation!,
                            arrivalStation: _arrivalStation!,
                            numberOfPassengers: _numberOfPassengers,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar( // 변경: 스낵바에 X 버튼 추가
                          content: const Text('출발역과 도착역을 모두 선택해주세요.'),
                          action: SnackBarAction(
                            label: 'X',
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
            ],
          ),
        ),
      ),
    );
  }
}