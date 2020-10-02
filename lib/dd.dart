import 'package:flutter/material.dart';

class ChatListSample extends StatefulWidget {
  @override
  ChatListSampleState createState() {
    return new ChatListSampleState();
  }
}

class ChatListSampleState extends State<ChatListSample> {
  TextEditingController myController = TextEditingController();

  List<String> messages = List();

  @override
  Widget build(BuildContext context) {
    final chatfield = TextFormField(
      controller: myController,
      style: TextStyle(
        decorationColor: Colors.white,
        color: Colors.white,
      ),
      autofocus: false,
      onSaved: (String value) {},
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintStyle: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.purple,
        body: Stack(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20, bottom: 100),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  chatfield,
                  MaterialButton(
                    child: Text("send message"),
                    onPressed: () {
                      setState(() {
                        messages.add(myController.text);
                        myController.clear();
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}
