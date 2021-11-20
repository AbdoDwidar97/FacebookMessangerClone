import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta/AppUI.dart';
import 'package:posta/Model/MChatItem.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget
{
  String profileName, imgUrl;

  ChatScreen({this.profileName, this.imgUrl});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State <ChatScreen>
{
  double w, h;
  List <MChatItem> messages = [];

  bool assetsButtonsStatus = false;

  var writeTxtController = TextEditingController();


  ChatScreenState()
  {
    messages.add(new MChatItem(
      isSender: true,
      message: "a Shit, here we go again !!!"
    ));

    messages.add(new MChatItem(
        isSender: true,
        message: "Where are you man!"
    ));

    messages.add(new MChatItem(
        isSender: false,
        message: "Oh,, How are you friend !"
    ));

    messages.add(new MChatItem(
        isSender: false,
        message: "It's long time man ..."
    ));

    messages.add(new MChatItem(
        isSender: false,
        message: "It's long time man ...\nIt's long time man ...\nIt's long time man ...\nIt's long time man ..."
    ));

    // ---------------

    messages.add(new MChatItem(
        isSender: true,
        message: "how is maggie and beth"
    ));

    messages.add(new MChatItem(
        isSender: false,
        message: "there are okay friend, how is carl and lory ?!!!"
    ));

    messages.add(new MChatItem(
        isSender: true,
        message: "all of us are okay, we missed you really ?!"
    ));

    messages.add(new MChatItem(
        isSender: false,
        message: "we too friend, we want to see you again, like old days."
    ));
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
                backgroundImage: NetworkImage(widget.imgUrl),
              ),
            ),

            SizedBox(width: w*1),

            Text(widget.profileName, style: TextStyle(fontSize: h*1.1, color: Colors.white, fontWeight: FontWeight.bold)),

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
                          onTap: (){

                          },
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
                  child: AppUI.innerTextField(context, w*30, h*2.5, h*1, writeTxtController, (assetsButtonsStatus) ? "Aa" : "Type a message...", TextInputType.multiline, Colors.grey[900], false, (){setState(() {

                  });}, (){
                    setState(() {
                      assetsButtonsStatus = false;
                    });
                  }),
                ),

                (this.writeTxtController.text.isNotEmpty) ? IconButton(
                  icon: Icon(Icons.send, color: Colors.blue[800]),
                  iconSize: w*4,
                  onPressed: (){
                    print("Send !!!");
                    setState(() {
                      this.messages.add(new MChatItem(
                        message: writeTxtController.text.trim(),
                        isSender: true,
                      ));

                      writeTxtController.text = "";
                    });
                  },
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
      body: ListView.builder(
        itemCount: this.messages.length,
        padding: EdgeInsets.only(left: w*1, right: w*1),
        itemBuilder: (context, idx)
        {
          return Container(
            padding: EdgeInsets.only(top: h*0.3),
            child: Column(
              children: [

                (idx > 0) ? (this.messages[idx - 1].isSender != this.messages[idx].isSender) ? SizedBox(height: h*1) : SizedBox() : SizedBox(),

                Row(
                  textDirection: (this.messages[idx].isSender)  ? TextDirection.rtl: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    (!this.messages[idx].isSender) ? SizedBox(
                        width: w*4,
                        height: w*4,
                        child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.imgUrl),
                      ),
                    ) : Icon(Icons.check_circle_outline, color: Colors.blue[800], size: w*2),

                    SizedBox(width: w*0.5),

                    Container(
                      padding: EdgeInsets.all(w*1.5),
                      decoration: BoxDecoration(
                        color: (this.messages[idx].isSender) ? Colors.blue[800] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                          width: w*25,
                          child: Text(this.messages[idx].message, style: TextStyle(fontSize: h*1, color: Colors.white))
                      ),
                    ),

                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}