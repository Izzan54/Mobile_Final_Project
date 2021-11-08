//import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile_project/bloc.dart';
import 'package:mobile_project/postpage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://besquare-demo.herokuapp.com'),
  );
  final _textBloc = TextBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      resizeToAvoidBottomInset: false,
      // ignore: unnecessary_new
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/cover.png"), fit: BoxFit.fill)),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        ScaleAnimatedText(
                          'Welcome',
                          scalingFactor: 0.3,
                          textStyle: const TextStyle(
                            fontSize: 40,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            shadows: [
                              Shadow(
                                blurRadius: 7.0,
                                color: Colors.grey,
                                offset: Offset(4.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  StreamBuilder(
                      stream: _textBloc.textStream,
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Username: ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey),
                              ),
                              TextField(
                                onChanged: (String text) =>
                                    _textBloc.updateText(text),
                              ),
                            ],
                          ),
                        );
                      }),
                  // creating the signup button
                  const SizedBox(height: 20),
                  // ignore: avoid_unnecessary_containers
                  Container(
                      margin: const EdgeInsets.only(top: 150.0),
                      child: MaterialButton(
                        minWidth: 180,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostPage(channel: channel)));
                        },
                        color: Colors.blueGrey.shade500,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          "Go To Homepage",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
