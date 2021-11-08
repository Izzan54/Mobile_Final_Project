import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/detailpost.dart';
import 'package:mobile_project/favourite.dart';
import 'package:mobile_project/createpost.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

// ignore: must_be_immutable
class PostPage extends StatefulWidget {
  PostPage({required this.channel, Key? key}) : super(key: key);
  WebSocketChannel channel;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {


  // ignore: deprecated_member_use
  List savedPost = [];
  void _getPosts() {
    widget.channel.sink.add('{"type": "get_posts"}');
  }

  void _deletePost() {
    widget.channel.sink.add('{"type": "delete_post","data": {"postId": string}}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  dynamic decodedPost;
  dynamic deletedPost;
  // ignore: non_constant_identifier_names
  List ListPost = [];

  // ignore: annotate_overrides
  initState() {
    super.initState();
    widget.channel.stream.listen((results) {
      decodedPost = jsonDecode(results);

      if (decodedPost['type'] == 'all_posts') {
        ListPost = decodedPost['data']['posts'];
        // ignore: avoid_print
        print(ListPost);
      }
      setState(() {});
    });
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              )),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  iconSize: 30,
                  icon: const Icon(
                    Icons.sort_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                    color: Colors.pink,
                    iconSize: 30,
                    onPressed: () {
                      pushToFavoritePostRoute(context);
                    },
                    icon: const Icon(Icons.favorite)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreatePage(channel: widget.channel)));
                  },
                  icon: const Icon(Icons.add_box_outlined),
                  iconSize: 30,
                )
              ],
            )
          ],
        ),
      ),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: ListPost.length,
        itemBuilder: (context, index) {

          bool isSaved = savedPost.contains(ListPost[index]);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DisplayPostRoute(DetailPost: ListPost[index]),
                ),
              );
            },

            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // ignore: avoid_unnecessary_containers

                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: NetworkImage("https://images.myperfectcolor.com/repositories/images/colors/true-value-gray-blue-paint-color-match-2.jpg"))
                          ),
                          child: 
                          SizedBox(
                          width: 120,
                          height: 120,
                          child: Image.network(
                                  ListPost[index]["image"],
                                  errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                  },
                                  fit: BoxFit.fill,
                                  ),
                        ),
                        ),
   
                                        
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                ListPost[index]["title"],
                                style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              // ignore: avoid_unnecessary_containers
                              Text(
                                    ListPost[index]["author"],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                              Text(
                                ListPost[index]["description"],
                              style: const TextStyle(fontSize: 15),)
                            ],
                          ),
                          ),
                        ),
                        // ignore: avoid_unnecessary_containers
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  iconSize: 20,
                                  onPressed: () {
                                    _deletePost();
                                    setState(() {
                                      ListPost.indexOf(ListPost[index]);
                                      ListPost.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.delete)),
                              IconButton(
                                  //isSaved ? Icons.favorite : Icons.favorite_border,
                                  color: isSaved ? Colors.red : Colors.blueGrey,
                                  //color: Colors.pink,
                                  iconSize: 20,
                                  onPressed: () {
                                    setState(() {
                                      if (isSaved) {
                                        savedPost.remove(ListPost[index]);
                                      } else {
                                        savedPost.add(ListPost[index]);
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.favorite)),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future pushToFavoritePostRoute(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) =>
              FavoritePostRoute(favoritePost: savedPost)),
    );
  }


}


