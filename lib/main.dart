import 'package:flutter/material.dart';
import 'package:flutter_train_app/home_page.dart'; // HomePage 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_train_app', // 프로젝트 명
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // 전체적인 앱의 기본 색상
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // AppBar 기본 배경색 투명
          elevation: 0, // AppBar 기본 그림자 제거
          iconTheme: IconThemeData(color: Colors.black), // AppBar 아이콘 색상
          titleTextStyle: TextStyle(
            color: Colors.black, // AppBar 타이틀 텍스트 색상
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(), // 초기 화면 이름을 HomePage로 설정
    );
  }
}