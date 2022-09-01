import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:posta/AppNavigator.dart';
import 'package:posta/AppUI.dart';
import 'package:posta/Model/Message.dart';
import 'package:posta/Model/OnlineFriend.dart';
import 'package:posta/View/ChatScreen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainPage extends StatefulWidget
{
  late final FirebaseApp firebaseApp;
  final reference = FirebaseDatabase.instance.ref();

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State <MainPage>
{
  late double w, h;

  late AppNavigator _appNavigator;

  List<OnlineFriend> onlineFriends = [];
  List<Message> messages = [];

  var searchController = TextEditingController();


  MainPageState()
  {
    this.onlineFriends.add(new OnlineFriend(
        name: "0",
        imageUrl: "0"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Daryl Dixon",
        imageUrl: "https://upload.wikimedia.org/wikipedia/en/d/db/Daryl_Dixon_Norman_Reedus.png"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Sara Tanc...",
        imageUrl: "https://upload.wikimedia.org/wikipedia/en/4/4f/SaraTancredi.jpg"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "The Prof...",
        imageUrl: "https://www.lunigal.com/images/stars/alvaro_morte-2165.jpg"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Carol C",
        imageUrl: "https://media1.popsugar-assets.com/files/thumbor/_jtQD5J_uAf2zAQ9Zfaa1NP4EAI/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2016/03/17/803/n/1922283/2227b7ca_edit_img_cover_file_17268548_1458238010_TWD_502_GP_0519_0192/i/Carol-Die-Walking-Dead.jpg"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Andrea Andrea",
        imageUrl: "https://i.pinimg.com/originals/a1/51/43/a1514382b1a79e2f7887e75b0f1358ca.png"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Glenn Rhee",
        imageUrl: "https://pbs.twimg.com/profile_images/577110013103058944/9nrBmDtj.jpeg"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Hershel T.Johns",
        imageUrl: "https://deadline.com/wp-content/uploads/2016/02/scott-wilson-1.jpg"
    ));

    // --------------------------------------------------

    this.messages.add(new Message(
        name: "Andrea Andrea",
        imageUrl: "https://i.pinimg.com/originals/a1/51/43/a1514382b1a79e2f7887e75b0f1358ca.png",
        lastMessage: "You: hahaahha LoL",
        sentDate: ". 7:00 PM"
    ));

    this.messages.add(new Message(
        name: "Daryl Dixon",
        imageUrl: "https://upload.wikimedia.org/wikipedia/en/d/db/Daryl_Dixon_Norman_Reedus.png",
        lastMessage: "The Gov attacks the pr...",
        sentDate: ". 10:20 AM"
    ));

    this.messages.add(new Message(
        name: "Carl Rick",
        imageUrl: "https://m.media-amazon.com/images/M/MV5BODU5OTIxODk3MV5BMl5BanBnXkFtZTgwNDA0MDAzNzE@._V1_.jpg",
        lastMessage: "You: Take care of yourself son.",
        sentDate: ". Fri"
    ));

    this.messages.add(new Message(
        name: "Hershel T.Johns",
        imageUrl: "https://deadline.com/wp-content/uploads/2016/02/scott-wilson-1.jpg",
        lastMessage: "Call",
        sentDate: ". 14 May"
    ));

    this.messages.add(new Message(
        name: "Carol C",
        imageUrl: "https://media1.popsugar-assets.com/files/thumbor/_jtQD5J_uAf2zAQ9Zfaa1NP4EAI/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2016/03/17/803/n/1922283/2227b7ca_edit_img_cover_file_17268548_1458238010_TWD_502_GP_0519_0192/i/Carol-Die-Walking-Dead.jpg",
        lastMessage: "Where is my daughter ?",
        sentDate: ". 7 Mars"
    ));

    this.messages.add(new Message(
        name: "Glenn Rhee",
        imageUrl: "https://pbs.twimg.com/profile_images/577110013103058944/9nrBmDtj.jpeg",
        lastMessage: "You: You saved my life...",
        sentDate: ". 22 Jan"
    ));

  }

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)
    {
      Provider.of<AppNavigator>(context, listen: false).setCurrentPageTitle("Chats");
      Provider.of<AppNavigator>(context, listen: false).setCurrentPageIDX(PAGES.MainPage);
    });
  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: w*1, right: w*1),
        child: Column(
          children: [

            SizedBox(height: h*1),

            AppUI.textField(context, w*50, h*3, h*1.1, searchController, "Search", TextInputType.emailAddress, Colors.grey[900]!, false),

            SizedBox(height: h*1),

            Container(
              height: h*6.5,
              child: onlineFriendsList(),
            ),

            SizedBox(height: h*0.5),

            Container(
              width: w*50,
              child: messagesList(),
            ),

          ],
        ),
      ),
    );
  }

  Widget onlineFriendsList()
  {
    if (this.onlineFriends.isEmpty){

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(
                width: w*6,
                height: w*6,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[600],
                ),
              ),

              SizedBox(height: h*1),

              SizedBox(
                width: w*6,
                height: w*6,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[600],
                ),
              ),

              SizedBox(height: h*1),

              SizedBox(
                width: w*6,
                height: w*6,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[600],
                ),
              ),

            ],
          ),
          baseColor: Colors.grey[700]!,
          highlightColor: Colors.grey[100]!,

        ),
      );

    }else {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this.onlineFriends.length,
          itemBuilder: (context, idx){

            if (idx == 0)
            {
              return Container(
                width: w*9,
                height: h*6.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      width: w*7,
                      height: w*7,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        child: Icon(Icons.video_call_rounded, size: w*4, color: Colors.white),
                      ),
                    ),

                    SizedBox(
                      width: w*7,
                      child: Text("Create Room", style: TextStyle(fontSize: h*1, color: Colors.white), textAlign: TextAlign.center),
                    ),
                  ],
                ),
              );
            }

            return InkWell(
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen(profileName: this.onlineFriends[idx].name!, imgUrl: this.onlineFriends[idx].imageUrl!)),
                );

              },
              child: Container(
                width: w*9,
                height: h*6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Stack(
                      children: [

                        SizedBox(
                          width: w*7,
                          height: w*7,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(this.onlineFriends[idx].imageUrl!),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SizedBox(
                            width: w*2,
                            height: w*2,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: SizedBox(
                                width: w*1.5,
                                height: w*1.5,
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: w*7,
                      child: Text(this.onlineFriends[idx].name!, style: TextStyle(fontSize: h*1, color: Colors.white), textAlign: TextAlign.center),
                    ),

                  ],
                ),
              ),

            );
          }
      );
    }

  }

  Widget messagesList()
  {
    return ListView.builder(
      itemCount: this.messages.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, idx) {

        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(profileName: this.messages[idx].name!, imgUrl: this.messages[idx].imageUrl!)),
            );
          },
          child: Container(
            width: w*50,
            padding: EdgeInsets.only(top: h*1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [

                    SizedBox(
                      width: w*7,
                      height: w*7,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(this.messages[idx].imageUrl!),
                      ),
                    ),

                    SizedBox(width: w*1.5),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(this.messages[idx].name!, style: TextStyle(fontSize: h*1.1, color: Colors.grey[300])),
                        SizedBox(height: h*0.3),
                        Text("${this.messages[idx].lastMessage} ${this.messages[idx].sentDate}", style: TextStyle(fontSize: h*1, color: Colors.grey[300])),
                      ],
                    ),

                  ],
                ),

                (this.messages[idx].lastMessage!.contains("Call")) ? InkWell(
                  onTap: (){},
                  child: SizedBox(
                    width: w*5,
                    height: w*5,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[900],
                      child: Icon(Icons.phone, color: Colors.white, size: w*3),
                    ),
                  ),
                ) : Icon(Icons.check_circle_rounded, color: Colors.grey[800], size: w*2),

              ],
            ),
          ),
        );
      },
    );
  }

}