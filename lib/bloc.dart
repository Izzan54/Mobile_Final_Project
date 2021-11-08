import 'dart:async';

class TextBloc {
  final _textController = StreamController<String>();
  Stream<String> get textStream => _textController.stream;
  //StreamSink<String> get textSink => _textController.sink;

  dispose() {
    _textController.close();
  }

  updateText(String text) {
    // ignore: unnecessary_null_comparison
    (text != null);
    _textController.sink.add(text);
  }
}

