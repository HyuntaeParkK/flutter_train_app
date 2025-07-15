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
      theme: ThemeData( // 밝은 테마 정의
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200], // 밝은 모드 배경
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardColor: Colors.white, // 밝은 모드 카드 색상
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData( // 다크 테마 (이것이 항상 적용됩니다)
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[850], // 다크 모드 배경 (아주 어두운 회색)
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white), // 다크 모드 AppBar 아이콘
          titleTextStyle: const TextStyle(
            color: Colors.white, // 다크 모드 AppBar 타이틀
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardColor: Colors.grey[800], // 다크 모드 카드 색상
        textTheme: Theme.of(context).textTheme.apply( // 다크 모드 기본 텍스트 색상
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark, // 항상 다크 모드로 설정
      home: const HomePage(), // 초기 화면 이름을 HomePage로 설정
    );
  }
}