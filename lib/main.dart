import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class Post {
  final int id;
  final String slug;
  final String url;
  final String title;
  final String content;
  final String image;

  Post({
    required this.id,
    required this.slug,
    required this.url,
    required this.title,
    required this.content,
    required this.image
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      slug: json['slug'],
      url: json['url'],
      title: json['title'],
      content: json['content'],
      image: json['image']
    );
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _Random(),
    );
  }
}

class _Random extends StatelessWidget {

  Future<List<Post>> fetchAllPosts() async {
    final response = await http.get(Uri.parse('http://jsonplaceholder.org/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception("Failed to load posts");
    }

  }

  

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: const Text('hwhwh YOYO')),
      body: Center(
        child: FutureBuilder(future: fetchAllPosts(), builder: (context,snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data?.length,
                itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget> [
                   Card(
                       child: ListTile(
                        leading: CircleAvatar(
                          child: Image.network('${snap.data?[index].image}')),
                        title: Text('${snap.data?[index].title}'),
                        subtitle:
                        Text('${snap.data?[index].content}'),
                        trailing: Icon(Icons.more_vert),
                        isThreeLine: true,
                  ),
                ),
                Divider()
              ],
            );
           
          },
        );
          }
          else if (snap.hasError) {
            return Text('error in fetch');
          }
          return Center(child: CircularProgressIndicator(),);
        }),
      )
    );
  }
}


class _MyHomePageState extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('hwhwh YOYO')),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget> [
                ListTile(
                  title:  Text('Item $index'),
                ),
                Divider()
              ],
            );
           
          },
        )
    );
  }
}
