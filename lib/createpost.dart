import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// ignore: must_be_immutable
class CreatePage extends StatefulWidget {
  //WebSocketChannel channel = IOWebSocketChannel.connect("ws://besquare-demo.herokuapp.com");

  CreatePage({required this.channel, Key? key}) : super(key: key);
  WebSocketChannel channel;

  @override
  CreatePageState createState() {
    return CreatePageState();
  }
}

class CreatePageState extends State<CreatePage> {
  late WebSocketChannel channel;
  // ignore: prefer_final_fields
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _imageURLcontroller = TextEditingController();

  void sendPost() {
    if (_titlecontroller.text.isNotEmpty &&
        _descriptioncontroller.text.isNotEmpty &&
        _imageURLcontroller.text.isNotEmpty) {
      widget.channel.sink.add(
          '{"type": "create_post","data": {"title": "${_titlecontroller.text}", "description": "${_descriptioncontroller.text}", "image": "${_imageURLcontroller.text}"}}');
      // ignore: avoid_print
      print("Yeay! New Post Created");
      _titlecontroller.clear();
      _descriptioncontroller.clear();
      _imageURLcontroller.clear();
      sendPost();
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              ))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          Form(
            child: TextFormField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: _titlecontroller,
            ),
          ),
          Form(
            child: TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              controller: _descriptioncontroller,
            ),
          ),
          Form(
            child: TextFormField(
              decoration: const InputDecoration(labelText: "Image URL"),
              controller: _imageURLcontroller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            onPressed: () {
              sendPost();
              const snackBar = SnackBar(
                content: Text('Yay! A post is created'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Create',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 20),),
          ),)
        ]),
      ),
    );
  }
}
