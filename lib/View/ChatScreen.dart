import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posta/AppUI.dart';
import 'package:posta/Model/MChatItem.dart';
import 'package:posta/Model/firebase_models/User.dart';
import 'package:posta/Model/firebase_models/file_class.dart';
import 'package:posta/Model/firebase_models/message_model2.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget
{
  String? profileName, imgUrl;

  ChatScreen({this.profileName, this.imgUrl});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State <ChatScreen>
{
  final chatsRef = FirebaseDatabase.instance.ref("Chats").child("-N2mHktnqxVtFUBAo2mz");

  late double w, h;
  List <MChatItem> messages = [];

  bool assetsButtonsStatus = false;

  var writeTxtController = TextEditingController();

  ScrollController _scrollController = new ScrollController();
  KeyboardVisibilityController _keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void initState()
  {
    super.initState();
    _initScreen();
  }

  void _initScreen()
  {
    _keyboardVisibilityController.onChange.listen((event) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    _getData();
  }

  void _getData()
  {
    chatsRef.onValue.listen((event)
    {
      Map<Object?, dynamic> data = jsonDecode(jsonEncode(event.snapshot.value));

      messages.clear();
      data.forEach((key, value)
      {
        messages.add(MChatItem(
            message: value["messgage"],
            receiverPhoto: value["user"]["photo"],
            imageFile: (value["file"] == null) ? null : FileClass.fromJson(value["file"]),
            audio: value["audio"] ?? null,
            timeStamp: DateTime.fromMillisecondsSinceEpoch(int.parse(value["timeStamp"])),
            isSender: (value["user"]["type"] == "0") ? false : true
          )
        );
      });

      messages.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));

      setState((){
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });

    });

  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            InkWell(
              child: Icon(Icons.arrow_back, color: Colors.blue[800], size: w*3.5),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),

            SizedBox(width: w*2),

            SizedBox(
              width: w*5,
              height: w*5,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.imgUrl!),
              ),
            ),

            SizedBox(width: w*1),

            Text(widget.profileName!, style: TextStyle(fontSize: h*1.1, color: Colors.white, fontWeight: FontWeight.bold)),

          ],
        ),
        actions: [

          IconButton(
            icon: Icon(Icons.call, color: Colors.blue[800]),
            iconSize: w*3.5,
            onPressed: (){},
          ),

          IconButton(
            icon: Icon(Icons.videocam, color: Colors.blue[800]),
            iconSize: w*3.5,
            onPressed: (){},
          ),

          IconButton(
            icon: Icon(Icons.info, color: Colors.blue[800]),
            iconSize: w*3.5,
            onPressed: (){},
          ),

        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          color: Colors.black,
          child: Container(
            height: h*4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    (assetsButtonsStatus) ? Row(
                      children: [

                        InkWell(
                          child: Icon(Icons.app_registration, color: Colors.blue[800], size: w*3),
                          onTap: (){

                          },
                        ),

                        SizedBox(width: w*1.5),

                        InkWell(
                          child: Icon(Icons.camera_alt, color: Colors.blue[800], size: w*3),
                          onTap: (){

                          },
                        ),

                        SizedBox(width: w*1.5),

                        InkWell(
                          child: Icon(Icons.photo, color: Colors.blue[800], size: w*3),
                          onTap: () => _pickImageAndUploadToFirebase(),
                        ),

                        SizedBox(width: w*1.5),

                        InkWell(
                          child: Icon(Icons.mic, color: Colors.blue[800], size: w*3),
                          onTap: (){

                          },
                        ),

                      ],
                    ) :
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.blue[800]),
                      iconSize: w*3,
                      onPressed: (){
                        setState(() {
                          this.assetsButtonsStatus = true;
                        });
                      },
                    ),
                  ],
                ),

                AnimatedContainer(
                  width: (assetsButtonsStatus) ? w*20 : w*35,
                  duration: Duration(milliseconds: 200),
                  child: AppUI.innerTextField(context, w*30, h*2.5, h*1, writeTxtController, (assetsButtonsStatus) ? "Aa" : "Type a message...", TextInputType.multiline, Colors.grey[900]!, false, (){
                    setState(() {

                  });}, (){
                    setState(() {
                      assetsButtonsStatus = false;
                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    });
                  }),
                ),

                (this.writeTxtController.text.isNotEmpty) ? IconButton(
                  icon: Icon(Icons.send, color: Colors.blue[800]),
                  iconSize: w*4,
                  onPressed: () => _btnSend(),
                ) :
                IconButton(
                  icon: Icon(Icons.favorite_outlined, color: Colors.red[900]),
                  iconSize: w*4,
                  onPressed: (){},
                ),

              ],
            ),
          ),
        ),
      ),
      body: KeyboardVisibilityProvider(
        controller: _keyboardVisibilityController,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: messages.length,
          controller: _scrollController,
          padding: EdgeInsets.only(left: w*1, right: w*1, bottom: MediaQuery.of(context).viewInsets.bottom != 0 ? h * 5 : h * 2),
          itemBuilder: (context, idx)
          {
            return Container(
              padding: EdgeInsets.only(top: h*0.3),
              child: Column(
                children: [

                  (idx > 0) ? (this.messages[idx - 1].isSender != this.messages[idx].isSender) ?
                  SizedBox(height: h*1) : SizedBox() : SizedBox(),

                  Align(
                    alignment: (this.messages[idx].isSender!) ? Alignment.centerRight : Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      textDirection: (this.messages[idx].isSender!)  ? TextDirection.rtl: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        (!this.messages[idx].isSender!) ? SizedBox(
                          width: w*4,
                          height: w*4,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(messages[idx].receiverPhoto!),
                          ),
                        ) : Icon(Icons.check_circle, color: Colors.blue[800], size: w*2),

                        SizedBox(width: w*0.5),

                        Container(
                          padding: EdgeInsets.all(w*1.5),
                          decoration: BoxDecoration(
                            color: (this.messages[idx].isSender!) ? Colors.blue[800] : Colors.grey[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: w * 25),
                              child: (messages[idx].imageFile == null) ? Text(this.messages[idx].message!,
                                  style: TextStyle(fontSize: h*1, color: Colors.white)
                              ) : Image.network(messages[idx].imageFile!.url!, width: w * 24, fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _btnSend() async
  {
    print("Send !!!");

    await chatsRef.push().set(MessageModel2(
        timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
        messgage: writeTxtController.text.trim(),
        user: User(
            email: "eng.aboali712@gmail.com",
            id: "2",
            name: "AhmedAbo",
            photo: "https://samanew.magic-chat.com/storage/users/https://samanew.magic-chat.com/storage/users/RmMLfxgFokcl4wlchfSsr9i3Z5rcj9fDtARnNDmN.png",
            toUserId: "1",
            type: "1",
            userLogo: "https://samanew.magic-chat.com/storage/offices/1.jpeg",
            userName: "سمو للسفر والسياحة"
        )
    ).toJson());

    setState(()
    {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      writeTxtController.text = "";
    });

  }

  _pickImageAndUploadToFirebase() async
  {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _uploadToFirebaseStorage(image!);
  }

  void _uploadToFirebaseStorage(XFile file) async
  {
    final _firebaseStorage = FirebaseStorage.instance;

    String uploadedFileName = "${file.name}_${DateTime.now().millisecondsSinceEpoch}";
    await _firebaseStorage.ref()
        .child('images/$uploadedFileName')
        .putFile(File(file.path));

    await _sendImageToFirebase(file, uploadedFileName);
  }

  Future<void> _sendImageToFirebase(XFile file, String uploadedFileName) async
  {
    final _firebaseStorage = FirebaseStorage.instance;

    String url = await _firebaseStorage.ref('images').child(uploadedFileName).getDownloadURL();

    await chatsRef.push().set(MessageModel2(
        timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
        file: FileClass(
            name: "${file.name}_${DateTime.now().millisecondsSinceEpoch}",
            type: "image",
            url: url
        ),
        user: User(
            email: "eng.aboali712@gmail.com",
            id: "2",
            name: "AhmedAbo",
            photo: "https://samanew.magic-chat.com/storage/users/https://samanew.magic-chat.com/storage/users/RmMLfxgFokcl4wlchfSsr9i3Z5rcj9fDtARnNDmN.png",
            toUserId: "1",
            type: "1",
            userLogo: "https://samanew.magic-chat.com/storage/offices/1.jpeg",
            userName: "سمو للسفر والسياحة"
        )
    ).toJson());

  }
}