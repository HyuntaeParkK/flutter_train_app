import 'package:flutter/cupertino.dart'; // CupertinoDialog를 위해 추가
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;
  const SeatPage({
    super.key,
    this.departureStation = '수서', // 기본값 설정 (HomePage에서 전달받지 않을 경우)
    this.arrivalStation = '부산', // 기본값 설정
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  final Set<String> _selectedSeats = {};

  final List<String> _seatColumns = ['A', 'B', 'C', 'D'];
  final int _maxSeatRows = 20; // 총 좌석의 행 갯수 20개

  // 좌석 위젯을 만드는 헬퍼 함수
  Widget _buildSeat(String seatName) {
    bool isSelected = _selectedSeats.contains(seatName);
    // 변경: 1A, 5C 등 특정 좌석의 예약 불가 로직을 제거합니다.
    // bool isUnavailable = (seatName == 'A1' || seatName == 'C5' || seatName == 'D10'); // 이 줄을 주석 처리하거나 삭제

    // isUnavailable 부분을 제거하고 isSelected에 따라 색상을 결정합니다.
    Color seatColor = isSelected ? Colors.purple : Colors.grey[300]!; // ❽ 색상 변경 (선택됨 - purple, 선택안됨 - grey[300])

    return GestureDetector(
      onTap: () {
        // 변경: isUnavailable 체크 로직을 제거합니다.
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(seatName); // 선택 해제
          } else {
            _selectedSeats.add(seatName); // 선택
          }
        });
      },
      child: Container(
        width: 50, // ❽ 좌석 위젯 너비 50
        height: 50, // ❽ 좌석 위젯 높이 50
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0), // ❽ 가로 간격 4, 세로 간격 8
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8), // ❽ 모서리 둥글기 8
        ),
      ),
    );
  }

  // A,B,C,D 레이블과 행 번호를 위한 공통 박스 위젯
  Widget _buildLabelBox(Widget child) {
    return Container(
      width: 50, // ❼ 각 글자 감싸고 있는 박스의 크기는 가로 50
      height: 50, // ❼ 각 글자 감싸고 있는 박스의 크기는 세로 50
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0), // 좌석 위젯과 동일한 마진
      child: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double listViewVerticalPadding = 20.0;

    return Scaffold(
      backgroundColor: Colors.purple[50], // 이미지 배경색과 유사하게 설정
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '좌석 선택', // ❶ 앱바 타이틀 글자에 별도의 스타일 지정 X
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // 출발/도착역 정보 복원 및 스타일 적용
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
              children: <Widget>[
                Text(
                  widget.departureStation, // HomePage에서 전달받은 값 사용
                  style: const TextStyle(
                    fontSize: 30, // ❸ 글자 크기 30
                    fontWeight: FontWeight.bold, // ❷ 글자 두께 FontWeight.bold
                    color: Colors.purple, // ❷ 글자 색상 Colors.purple
                  ),
                ),
                const SizedBox(width: 10.0),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: const Icon(
                    Icons.arrow_circle_right_outlined, // ❹ 아이콘 데이터
                    color: Colors.grey, // 이미지상 회색
                    size: 30, // ❹ 아이콘 크기 30
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  widget.arrivalStation, // HomePage에서 전달받은 값 사용
                  style: const TextStyle(
                    fontSize: 30, // ❸ 글자 크기 30
                    fontWeight: FontWeight.bold, // ❷ 글자 두께 FontWeight.bold
                    color: Colors.purple, // ❷ 글자 색상 Colors.purple
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // 좌석 상태 표시 복원 및 스타일 적용
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
              children: <Widget>[
                // 선택됨 상태
                Container(
                  width: 24, // ❺ 너비 24
                  height: 24, // ❺ 높이 24
                  decoration: BoxDecoration(
                    color: Colors.purple, // ❺ 색상 Colors.purple
                    borderRadius: BorderRadius.circular(8), // ❺ 모서리 둥글기 8
                  ),
                ),
                const SizedBox(width: 4), // ❻ 좌석 상태 박스와 좌석 상태 텍스트의 간격 4
                const Text('선택됨'), // ❻ 좌석 상태 텍스트 별도 스타일 지정 X
                const SizedBox(width: 20), // ❻ 선택됨, 선택안됨 간격 20
                // 선택 가능 상태 (이미지에는 선택됨으로 되어 있으나, 기능상 '선택 가능'이 맞으므로 변경)
                Container(
                  width: 24, // ❺ 너비 24
                  height: 24, // ❺ 높이 24
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!, // ❺ 색상 Colors.grey[300]!
                    borderRadius: BorderRadius.circular(8), // ❺ 모서리 둥글기 8
                  ),
                ),
                const SizedBox(width: 4), // ❻ 좌석 상태 박스와 좌석 상태 텍스트의 간격 4
                const Text('선택 가능'), // ❻ 좌석 상태 텍스트 별도 스타일 지정 X
              ],
            ),
          ),
          const SizedBox(height: 30.0),

          // 좌석 배치도
          Expanded(
            child: Align( // SingleChildScrollView를 Align으로 감싸서 가로 중앙 정렬
              alignment: Alignment.center,
              child: SingleChildScrollView( // 화면 내에서 스크롤이 되는 영역
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: listViewVerticalPadding), // 위 아래로 패딩 20
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 내용 가운데 정렬 (세로 정렬)
                  children: [
                    // 최상단에 ABCD 레이블 표시 (fontSize 18)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 열 헤더도 가운데 정렬
                      children: [
                        // A열 헤더
                        _buildLabelBox(
                          Text(
                            _seatColumns[0],
                            style: const TextStyle(
                              fontSize: 18, // ❻ 글자 크기 18
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        // B열 헤더
                        _buildLabelBox(
                          Text(
                            _seatColumns[1],
                            style: const TextStyle(
                              fontSize: 18, // ❻ 글자 크기 18
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        // 행 번호가 들어갈 빈 공간
                        _buildLabelBox(const SizedBox.shrink()),
                        // C열 헤더
                        _buildLabelBox(
                          Text(
                            _seatColumns[2],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        // D열 헤더
                        _buildLabelBox(
                          Text(
                            _seatColumns[3],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        // 마지막 빈 공간 (D열 우측 여백)
                        _buildLabelBox(const SizedBox.shrink()),
                      ],
                    ),
                    // GridView는 Row 안에 마진을 이미 가지고 있으므로, 이 SizedBox는 제거

                    // 좌석 Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // GridView 자체 스크롤 비활성화
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6, // 6개 열 (A, B, 행 번호, C, D, 빈 공간)
                        childAspectRatio: (50.0 + (4.0 * 2)) / (50.0 + (8.0 * 2)), // 58.0 / 66.0
                        crossAxisSpacing: 0.0, // 마진으로 간격을 제어하므로 GridView 스페이싱은 0
                        mainAxisSpacing: 0.0, // 마진으로 간격을 제어하므로 GridView 스페이싱은 0
                      ),
                      itemCount: _maxSeatRows * 6, // 총 20개의 행
                      itemBuilder: (context, index) {
                        final int rowNum = index ~/ 6 + 1; // 행 번호 (1부터 시작)
                        final int colPos = index % 6; // 현재 열 위치 (0부터 5)

                        if (colPos == 2) { // 각 행마다 가운데 행 번호 출력
                          return _buildLabelBox(
                            Text(
                              '$rowNum',
                              style: const TextStyle(
                                fontSize: 18, // ❻ 글자 크기 18
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          );
                        } else if (colPos == 0) { // A열
                          String seatName = '${_seatColumns[0]}$rowNum';
                          return _buildSeat(seatName);
                        } else if (colPos == 1) { // B열
                          String seatName = '${_seatColumns[1]}$rowNum';
                          return _buildSeat(seatName);
                        } else if (colPos == 3) { // C열
                          String seatName = '${_seatColumns[2]}$rowNum';
                          return _buildSeat(seatName);
                        } else if (colPos == 4) { // D열
                          String seatName = '${_seatColumns[3]}$rowNum';
                          return _buildSeat(seatName);
                        } else { // colPos == 5 (마지막 빈 공간)
                          return _buildLabelBox(const SizedBox.shrink()); // 빈 박스
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0), // 리스트뷰 영역 하단과 버튼 사이 간격

          // 예매 하기 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                // 변경 시작: 버튼 onPressed 로직
                onPressed: () {
                  if (_selectedSeats.isEmpty) {
                    // 선택된 좌석이 없으면 아무 반응 없음
                    return; // 함수 종료
                  }

                  // 선택된 좌석이 있으면 showCupertinoDialog 출력
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text('예매 하시겠습니까?'),
                      content: Text('좌석: ${_selectedSeats.join(', ')}'), // 선택된 좌석 표시
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text('취소', style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            Navigator.pop(context); // Dialog 제거
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('확인', style: TextStyle(color: Colors.blue)),
                          onPressed: () {
                            // 확인 누를 시 HomePage로 이동 (뒤로가기 두번)
                            Navigator.pop(context); // Dialog 제거
                            Navigator.pop(context); // SeatPage 제거 (HomePage로 이동)
                          },
                        ),
                      ],
                    ),
                  );
                },
                // 변경 끝: 버튼 onPressed 로직

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // ❾ 버튼 색상 Colors.purple
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // ❾ 모서리 둥글기 20
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '예매 하기',
                  style: TextStyle(
                    fontSize: 18, // ❾ 글자 크기 18
                    fontWeight: FontWeight.bold, // ❾ 글자 두께 FontWeight.bold
                    color: Colors.white, // ❾ 글자 색상 Colors.white
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0), // 하단 여백 (safe area를 위한)
        ],
      ),
    );
  }
}