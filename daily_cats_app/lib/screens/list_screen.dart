import 'package:daily_cats_app/screens/detail_screen.dart';
import 'package:daily_cats_app/screens/upload_screen.dart';
import 'package:flutter/material.dart';
import '../models/cat.dart';

final List<Cat> cats = [
  Cat(
    id: "1",
    name: "별님이",
    title: "오늘의 귀염둥이",
    link: "assets/images/cat_01.jpg",
    likeCount: 1930,
    replyCount: 6,
    created: DateTime(2022, 11, 13, 22, 14, 53, 982),
  ),
  Cat(
    id: "2",
    name: "별님이",
    title: "오늘의 귀염둥이",
    link: "assets/images/cat_02.jpg",
    likeCount: 1930,
    replyCount: 6,
    created: DateTime(2022, 11, 13, 22, 14, 53, 982),
  ),
  Cat(
    id: "3",
    name: "별님이",
    title: "오늘의 귀염둥이",
    link: "assets/images/cat_03.jpg",
    likeCount: 1930,
    replyCount: 6,
    created: DateTime(2022, 11, 13, 22, 14, 53, 982),
  ),
  Cat(
    id: "4",
    name: "별님이",
    title: "오늘의 귀염둥이",
    link: "assets/images/cat_04.jpg",
    likeCount: 1930,
    replyCount: 6,
    created: DateTime(2022, 11, 13, 22, 14, 53, 982),
  ),
  Cat(
    id: "5",
    name: "별님이",
    title: "오늘의 귀염둥이",
    link: "assets/images/cat_05.jpg",
    likeCount: 1930,
    replyCount: 6,
    created: DateTime(2022, 11, 13, 22, 14, 53, 982),
  ),
  Cat(
    id: "6",
    name: "별님이",
    title: "오늘의 귀염둥이",
    link: "assets/images/cat_06.jpg",
    likeCount: 1930,
    replyCount: 6,
    created: DateTime(2022, 11, 13, 22, 14, 53, 982),
  ),
];

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(
        title: const Text("Daily Cats"),
        actions: [
          IconButton(
            onPressed:  () {
              showDialog(
                context: context,
                builder: (_) => const UploadScreen(),
              );
            },
            icon: const Icon(Icons.camera_alt),
          )
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio:  1.0,
        ),
        itemCount: cats.length,
        itemBuilder: (_, int index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  cat: cats[index],
                  ),
              )
            );
          },
          child: Image.asset(
            cats[index].link,
            fit: BoxFit.cover,
          )
        )
      )
    );
  }
}