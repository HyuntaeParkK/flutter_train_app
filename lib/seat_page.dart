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

  Widget _buildSeat(String seatName) {
    bool isSelected = _selectedSeats.contains(seatName);
    Color seatColor = isSelected ? Colors.purple : Colors.grey[600]!;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(seatName);
          } else {
            if (_selectedSeats.length < widget.numberOfPassengers) {
              _selectedSeats.add(seatName);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.numberOfPassengers}명의 좌석을 선택해주세요.'),
                  action: SnackBarAction(
                    label: 'X',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            }
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

  Widget _buildLabelBox(Widget child) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      alignment: Alignment.center,
      child: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double listViewVerticalPadding = 20.0;
    const double seatsAreaWidth = 310.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).appBarTheme.iconTheme?.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '좌석 선택',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // 출발/도착역 정보
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 10.0),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[700],
                  ),
                  child: const Icon(
                    Icons.arrow_circle_right_outlined,
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
                    color: Colors.purple,
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
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '선택됨',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[600]!,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '선택 가능',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),

          // 좌석 배치도 (항상 화면 중앙!)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: listViewVerticalPadding,
              ),
              child: Center(
                child: SizedBox(
                  width: seatsAreaWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 헤더 Row (A B [번호] C D)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLabelBox(
                            Text(
                              'A',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          _buildLabelBox(
                            Text(
                              'B',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          _buildLabelBox(
                            const SizedBox.shrink(),
                          ),
                          _buildLabelBox(
                            Text(
                              'C',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          _buildLabelBox(
                            Text(
                              'D',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 좌석 Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              childAspectRatio: 58 / 66,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                            ),
                        itemCount: _maxSeatRows * 5,
                        itemBuilder: (context, index) {
                          final int rowNum = index ~/ 5 + 1;
                          final int colPos = index % 5;

                          if (colPos == 2) {
                            return _buildLabelBox(
                              Text(
                                '$rowNum',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
          ),
          const SizedBox(height: 20.0),

          // 예매 하기 버튼 (컴포넌트화)
          CustomPurpleButton(
            text: '예매 하기',
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
                    content: Text(
                      '${widget.numberOfPassengers}명의 좌석을 선택해주세요. (현재 ${_selectedSeats.length}개 선택)',
                    ),
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
                  content: Text(
                    '인원: ${widget.numberOfPassengers}명\n'
                    '좌석: ${_selectedSeats.map((s) => s.replaceFirstMapped(RegExp(r'^([A-D])(\d+)$'), (m) => '${m[1]}-${m[2]}')).join(', ')}',
                  ),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      child: const Text(
                        '취소',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text(
                        '확인',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

// --------------------
// 재사용 가능한 커스텀 버튼 위젯
// --------------------
class CustomPurpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  const CustomPurpleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
