import 'package:flutter/material.dart';

class GridviewScreen extends StatefulWidget {
  const GridviewScreen({super.key});

  @override
  State<GridviewScreen> createState() => _GridviewScreenState();
}

class _GridviewScreenState extends State<GridviewScreen> {

  List<Widget> productWidgetList = List.generate(
    10, (index) => Card( 
      elevation: 4,   // Card 그림자 효과 크기
      child: GridTile(
        header: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.more_vert),
            ),
          ],
        ),
        footer: Column(
          children: [
            Text("상품 제목 ${index + 1}"),
            Text("상품 설명 ${index + 1}"),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Image.asset(
              'image/product${index + 1}.webp',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("그리드 뷰"),
      ),

      body: Container(
        child: Center(

          // 정적 그리드 뷰
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,        // 열의 개수
              crossAxisSpacing: 10.0,   // 열의 간격
              mainAxisSpacing: 10.0,    // 행의 간격
            ),
            children: productWidgetList,
          ),
        ),
      ),
    );
  }
}