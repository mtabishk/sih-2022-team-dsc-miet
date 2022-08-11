import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/models/chat_model.dart';
import 'package:rive/rive.dart';

class ChatScreeningPage extends StatefulWidget {
  const ChatScreeningPage({Key? key, required this.animationCharacter})
      : super(key: key);
  final String animationCharacter;

  @override
  State<ChatScreeningPage> createState() => _ChatScreeningPageState();
}

class _ChatScreeningPageState extends State<ChatScreeningPage> {
  final _textFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatModel> _randomQns = [
    ChatModel(message: "Glad to hear that", isUser: false),
    ChatModel(message: "How old are you ?", isUser: false),
    ChatModel(message: "How are you feeling ?", isUser: false),
  ];

  List<ChatModel> _chatBotQns = [
    ChatModel(message: "Hello, how are you doing?", isUser: false),
  ];
  List<ChatModel> _userAns = [];
  int _currentQuestionIndex = 1;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textFieldController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int qnIndex = 0;
    int ansIndex = 0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: show Doctor animation here
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: RiveAnimation.asset(widget.animationCharacter)),
                  Positioned(
                    left: 8.0,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        // keyboardDismissBehavior:
                        //   ScrollViewKeyboardDismissBehavior.onDrag,
                        controller: _scrollController,
                        reverse: false,
                        itemCount: _chatBotQns.length + _userAns.length,
                        itemBuilder: (BuildContext context, int index) {
                          MainAxisAlignment _mainAxisAlignment =
                              MainAxisAlignment.start;

                          ChatModel _currentChat =
                              ChatModel(message: "ahhhaa", isUser: false);

                          // odd index == user's message
                          if (index % 2 != 0) {
                            _mainAxisAlignment = MainAxisAlignment.end;
                            if (ansIndex < _userAns.length) {
                              _currentChat = _userAns[ansIndex];

                              ansIndex++;
                            }
                          } else {
                            _mainAxisAlignment = MainAxisAlignment.start;
                            if (qnIndex < _chatBotQns.length) {
                              _currentChat = _chatBotQns[qnIndex];

                              qnIndex++;
                            }
                          }
                          return Row(
                            mainAxisAlignment: _mainAxisAlignment,
                            children: [
                              if (_currentChat.isUser == false)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage:
                                        AssetImage("assets/icons/dash.png"),
                                  ),
                                ),
                              Container(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    " " + _currentChat.message + " ",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        backgroundColor:
                                            Colors.black.withOpacity(0.7)),
                                  )),
                              if (_currentChat.isUser == true)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: AssetImage(
                                        "assets/images/tabish-picture.png"),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    MessageComposerField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MessageComposerField() {
    return Container(
      margin: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 2.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 50.0,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sentiment_satisfied_alt_outlined),
            splashRadius: 50.0,
            color: Colors.blueGrey,
          ),
          Expanded(
              child: TextField(
            controller: _textFieldController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration.collapsed(
              hintText: ('Type your message...'),
            ),
          )),
          IconButton(
            onPressed: () async {
              if (_textFieldController.text.isNotEmpty) {
                setState(() {
                  _userAns.add(ChatModel(
                      message: _textFieldController.text, isUser: true));
                });
                _textFieldController.clear();
                await Future.delayed(Duration(milliseconds: 1000));
                setState(() {
                  if (_currentQuestionIndex < _randomQns.length) {
                    _chatBotQns.add(_randomQns[_currentQuestionIndex]);
                    _currentQuestionIndex++;
                  }
                });
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.fastOutSlowIn,
                );
                print("scrolled");
              }
            },
            icon: Icon(Icons.send),
            splashRadius: 50.0,
            color: Colors.blueGrey,
          )
        ],
      ),
    );
  }
}
