import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_app/models/memo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


void main() {
  // SharedPrefences 공유 환경설정에 데이터 저장 예제
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: 
          const FileApp(),
    );
  }
}


class FileApp extends StatefulWidget {
  const FileApp({super.key});

  @override
  State<FileApp> createState() => _FileAppState();
}

class _FileAppState extends State<FileApp> {

  TextEditingController _controller = TextEditingController();
  List<Memo> itemList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    List<Memo> savedItemList = await readListFile();

    setState(() {
      itemList = savedItemList;
    });
  }
  

  // 파일 데이터를 불러오는 함수
  // 📕 ➡ List
  Future<List<Memo>> readListFile() async {

    List<Memo> itemList = [];

    // 최초 파일 생성
    // - 처음 파일 생성 시, SharedPeferences 로 'frist' 라는 데이터를 확인
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    var firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync()
                     .whereType<File>()
                     .where( (file) => file.path.endsWith('.txt') )
                     .toList();

    // 최초인 경우 
    // 1. null  2. false  
    if( firstCheck == null || firstCheck == false || files.isEmpty ) {
      pref.setBool(key, true);
      var initial = await DefaultAssetBundle.of(context).loadString('repo/test.txt');
      var lines = initial.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty);
      List<Memo> initialList = [];
      for (var line in lines) {
        var id = Uuid().v4();
        var file = File('repo/${id}.txt');
        await file.writeAsString(line);

        initialList.add(Memo(id: id, text: line));
      }
      return initialList;
    }
    var array = files.map((file) => file.readAsStringSync()).join('\n').split('\n');   // \n (엔터)
    for (var item in array) {
      itemList.add(Memo(id: Uuid().v4(), text: item));
    }

    return itemList;
  }

  // 파일 데이터를 저장하는 함수
  void writeListFile(String data) async {
    // 파일 가져오기
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/test.txt').readAsString();
    // 기존 파일에 새 데이터 추가
    file = file + '\n' + data;
    // 파일 저장
    File(dir.path + '/test.txt').writeAsStringSync(file);
  }

  // 파일 데이터를 갱신하는 함수
  Future<bool> deleteListFile(int index) async {
    // itemList 에서 index 에 해당하는 데이터 삭제
    List<Memo> copyList = [];
    copyList.addAll(itemList);
    copyList.removeAt(index);

    // copyList 의 데이터들을 '\n' 로 구분하여 문자열로 변환
    var fileData = "";
    for (var item in copyList) {
      fileData += item.text + "\n";
    }
    // 파일 저장
    try {
      var dir = await getApplicationDocumentsDirectory();
      File(dir.path + '/test.txt').writeAsStringSync(fileData);
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File App'),),
      body: Container(
        child: Center(
          child: Column(
            children: [
              // TextFied : controller, keyboardType
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.text,
                        onSubmitted: (data) {
                          print(data);
                          writeListFile(data);
                          setState(() {
                            itemList.add(Memo(id: Uuid().v4(), text: data));
                          });
                          _controller.text = '';
                        },
                      ),
              ),
              const SizedBox(height: 10.0,),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return 
                        GestureDetector(
                          onLongPress: () async {
                            // 길게 누른 카드 삭제
                            bool check = await deleteListFile(index);
                            if( check ) {
                              setState(() {
                                itemList.removeAt(index);
                              });
                            }
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    itemList[index].text,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color(0xFFEF5350),
                                    ),
                                    onPressed: () async {
                                      bool check = await deleteListFile(index);
                                      if ( check ) {
                                        setState(() {
                                          itemList.removeAt(index);
                                        });
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        
                  },
                  itemCount: itemList.length,
                )
              ),

            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeListFile(_controller.text);
          setState(() {
            itemList.add(Memo(id: Uuid().v4(), text: _controller.text));
          });
          _controller.text = '';
        },
        child: Icon(Icons.create),
      ),
    );
  }
}