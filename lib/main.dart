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
      title: 'flutter_train_app', // 프로젝트 명 반영
      // 변경 시작: 다크 테마 적용을 위한 theme, darkTheme, themeMode 설정
      theme: ThemeData( // 기본 밝은 테마
        primarySwatch: Colors.deepPurple, // 앱의 기본 색상 (AppBar 등)
        scaffoldBackgroundColor: Colors.grey[100], // Scaffold 기본 배경색 (HomePage의 Colors.grey[100] 대체)
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
        brightness: Brightness.light, // 이 테마가 밝은 테마임을 명시
      ),
      darkTheme: ThemeData( // 다크 테마
        primarySwatch: Colors.deepPurple, // 다크 테마에서도 기본 색상 유지
        scaffoldBackgroundColor: Colors.grey[850], // 다크 모드에서의 Scaffold 배경색 (아주 어두운 회색)
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white), // 다크 모드 AppBar 아이콘 색상
          titleTextStyle: const TextStyle(
            color: Colors.white, // 다크 모드 AppBar 타이틀 텍스트 색상
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardColor: Colors.grey[800], // 다크 모드에서의 Card 색상
        textTheme: Theme.of(context).textTheme.apply( // 다크 모드 텍스트 색상 기본값
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        brightness: Brightness.dark, // 이 테마가 어두운 테마임을 명시
      ),
      themeMode: ThemeMode.system, // 시스템 설정에 따라 테마 자동 전환 (가장 권장되는 방식)
      // 변경 끝

      home: const HomePage(), // 초기 화면 이름을 HomePage로 설정
    );
  }
}