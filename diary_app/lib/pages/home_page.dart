import 'package:diary_app/services/file_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<DiaryEntry> _diaryList = [
    DiaryEntry(
      path: '/storage/2026-03-27_1120/txt',
      date: '2026-03-27',
      time: '11:20',
      title: '다이어리 앱 만들었따!'
    ),
    DiaryEntry(
      path: '/storage/2026-03-27_1120/txt',
      date: '2026-03-26',
      time: '11:20',
      title: '다이어리 앱 만들었따!'
    ),
    DiaryEntry(
      path: '/storage/2026-03-27_1120/txt',
      date: '2026-03-25',
      time: '11:20',
      title: '다이어리 앱 만들었따!'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _builderDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
      title: const Text("나의 다이어리"),
      actions: [
        // 검색 아이콘 버튼
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search)
        ),
        // 선택 삭제 아이콘 버튼
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.checklist_rounded)
        ),
      ],
    );
  }

  // FloatingActionButton
  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, "/write");
      },
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
      child: const Icon(Icons.edit),
    );
  }

  // body
  Widget _buildBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _diaryList.length,
      itemBuilder: (context, index) {
        final entry = _diaryList[index];
        final date = entry.date;
        final time = entry.time;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber.shade100,
              child: const Icon(Icons.book, color: Colors.amber),
            ),
            title: Text(entry.title),
            subtitle: Text(date),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey,),
            onTap: () {},
          ),
        );
      }
    );
  }

  // Drawer
  Widget _builderDrawer() {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.menu_book,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "나의 다이어리",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text("달력으로 보기"),
                  onTap: () {
                    Navigator.pushNamed(context, "/calendar");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list_alt),
                  title: const Text("전체 일기"),
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search_rounded),
                  title: const Text("일기 검색"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.checklist_rounded),
                  title: const Text("선택 삭제"),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons. edit_note),
            title: const Text("새 일기 작성"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}