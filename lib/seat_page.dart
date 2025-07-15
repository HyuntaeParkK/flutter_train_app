import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;
  final int numberOfPassengers;

  const SeatPage({
    super.key,
    this.departureStation = '수서',
    this.arrivalStation = '부산',
    this.numberOfPassengers = 1,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  final Set<String> _selectedSeats = {};

  final List<String> _seatColumns = ['A', 'B', 'C', 'D'];
  final int _maxSeatRows = 20;

  // 좌석 위젯을 만드는 헬퍼 함수
  Widget _buildSeat(String seatName) {
    bool isSelected = _selectedSeats.contains(seatName);
    // 변경: 좌석 색상 - 선택된 것은 purple, 선택 가능한 것은 darkTheme에 맞게 light grey
    // Colors.grey[300]! 대신 Theme.of(context).cardColor 같은 것을 사용할 수도 있지만,
    // 여기서는 명확한 구분을 위해 특정 회색 톤을 유지합니다.
    Color seatColor = isSelected ? Colors.purple : Colors.grey[600]!; // 다크 모드 배경에서 잘 보일 회색 톤으로 변경

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(seatName); // 선택 해제
          } else {
            _selectedSeats.add(seatName); // 선택
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // A,B,C,D 레이블과 행 번호를 위한 공통 박스 위젯
  Widget _buildLabelBox(Widget child) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      // 변경: 레이블 박스의 배경색을 투명 또는 테마 색상으로 설정 (필요시)
      // decoration: BoxDecoration(color: Theme.of(context).cardColor.withOpacity(0.0)),
      child: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double listViewVerticalPadding = 20.0;

    return Scaffold(
      // 변경: Scaffold의 backgroundColor는 main.dart의 ThemeData에서 관리하므로 여기서 삭제합니다.
      // backgroundColor: Colors.purple[50], // 이 줄을 삭제하거나 주석 처리합니다.
      appBar: AppBar(
        leading: IconButton(
          // 변경: 뒤로가기 아이콘 색상도 테마에 맞춰 변경
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).appBarTheme.iconTheme?.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '좌석 선택',
          // 변경: AppBar 타이틀 텍스트 색상도 테마에 맞춰 변경
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // 출발/도착역 정보
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple, // 보라색은 유지
                  ),
                ),
                const SizedBox(width: 10.0),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // 변경: 화살표 원형 배경색도 다크 모드에 맞춰 변경 (예: 조금 더 어두운 회색)
                    color: Colors.grey[700],
                  ),
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    // 변경: 화살표 아이콘 색상도 다크 모드에 맞춰 변경
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  widget.arrivalStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple, // 보라색은 유지
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // 좌석 상태 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 선택됨 상태 (보라색)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                // 변경: 텍스트 색상을 테마의 기본 bodyColor로 설정하여 다크모드에서 잘 보이게
                Text('선택됨', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                const SizedBox(width: 20),
                // 선택 가능 상태 (회색)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[600]!, // 다크 모드에 맞춰 회색 톤 조정
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                // 변경: 텍스트 색상을 테마의 기본 bodyColor로 설정하여 다크모드에서 잘 보이게
                Text('선택 가능', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
              ],
            ),
          ),
          const SizedBox(height: 30.0),

          // 좌석 배치도
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: listViewVerticalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 최상단에 ABCD 레이블 표시
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLabelBox(
                          Text(
                            _seatColumns[0],
                            style: TextStyle( // 변경: 텍스트 색상을 다크모드에 맞춰 밝게 조정
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70, // 조금 투명한 흰색
                            ),
                          ),
                        ),
                        _buildLabelBox(
                          Text(
                            _seatColumns[1],
                            style: TextStyle( // 변경: 텍스트 색상을 다크모드에 맞춰 밝게 조정
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        _buildLabelBox(const SizedBox.shrink()),
                        _buildLabelBox(
                          Text(
                            _seatColumns[2],
                            style: TextStyle( // 변경: 텍스트 색상을 다크모드에 맞춰 밝게 조정
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        _buildLabelBox(
                          Text(
                            _seatColumns[3],
                            style: TextStyle( // 변경: 텍스트 색상을 다크모드에 맞춰 밝게 조정
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        _buildLabelBox(const SizedBox.shrink()),
                      ],
                    ),
                    // 좌석 Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: (50.0 + (4.0 * 2)) / (50.0 + (8.0 * 2)),
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                      ),
                      itemCount: _maxSeatRows * 6,
                      itemBuilder: (context, index) {
                        final int rowNum = index ~/ 6 + 1;
                        final int colPos = index % 6;

                        if (colPos == 2) {
                          return _buildLabelBox(
                            Text(
                              '$rowNum',
                              style: TextStyle( // 변경: 행 번호 텍스트 색상을 다크모드에 맞춰 밝게 조정
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else if (colPos == 0) {
                          String seatName = '${_seatColumns[0]}$rowNum';
                          return _buildSeat(seatName);
                        } else if (colPos == 1) {
                          String seatName = '${_seatColumns[1]}$rowNum';
                          return _buildSeat(seatName);
                        } else if (colPos == 3) {
                          String seatName = '${_seatColumns[2]}$rowNum';
                          return _buildSeat(seatName);
                        } else if (colPos == 4) {
                          String seatName = '${_seatColumns[3]}$rowNum';
                          return _buildSeat(seatName);
                        } else {
                          return _buildLabelBox(const SizedBox.shrink());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // 예매 하기 버튼
          SizedBox(
            width: double.infinity,
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedSeats.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('좌석을 선택해주세요.'),
                      action: SnackBarAction(
                        label: 'X',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                  return;
                }

                if (_selectedSeats.length != widget.numberOfPassengers) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.numberOfPassengers}명의 좌석을 선택해주세요. (현재 ${_selectedSeats.length}개 선택)'),
                      action: SnackBarAction(
                        label: 'X',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                  return;
                }

                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text('예매 하시겠습니까?'),
                    content: Text('인원: ${widget.numberOfPassengers}명\n좌석: ${_selectedSeats.join(', ')}'),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        child: const Text('취소', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('확인', style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: const Text(
                '예매 하기',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}