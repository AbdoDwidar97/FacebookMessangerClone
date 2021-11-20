import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta/AppNavigator.dart';
import 'package:posta/AppUI.dart';
import 'package:posta/Model/Message.dart';
import 'package:posta/Model/OnlineFriend.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State <MainScreen>
{
  double w, h;

  AppNavigator _appNavigator;

  List<OnlineFriend> onlineFriends = [];
  List<Message> messages = [];

  var searchController = TextEditingController();


  MainScreenState()
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
        lastMessage: "You: You saved my life, Thanks",
        sentDate: ". 22 Jan"
    ));

  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    _appNavigator = Provider.of<AppNavigator>(context);

    return WillPopScope(
      onWillPop: () async{
        if (_appNavigator.navPages.length == 1) {
          return true;
        }
        _appNavigator.popUpPage();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: Padding(
            padding: EdgeInsets.only(left: w*1),
            child: SizedBox(
              width: w*4,
              height: w*4,
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pinimg.com/originals/e2/28/b3/e228b3b55721db68685163e603d123b0.jpg"),
              ),
            ),
          ),
          title: Text(_appNavigator.currentPageTitle, style: TextStyle(fontSize: h*1.6, color: Colors.white, fontWeight: FontWeight.bold)),
          actions: [

            (_appNavigator.currentPageIDX == PAGES.MainPage.index) ? Padding(
              padding: EdgeInsets.only(right: w*1),
              child: InkWell(
                onTap: (){},
                child: SizedBox(
                  width: w*5,
                  height: w*5,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    child: Icon(Icons.camera_alt, size: w*3, color: Colors.white),
                  ),
                ),
              ),
            ) : SizedBox(),

            (_appNavigator.currentPageIDX == PAGES.PeoplePage.index) ? Padding(
              padding: EdgeInsets.only(right: w*1),
              child: InkWell(
                onTap: (){},
                child: SizedBox(
                  width: w*5,
                  height: w*5,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    child: Icon(Icons.all_inbox, size: w*3, color: Colors.white),
                  ),
                ),
              ),
            ) : SizedBox(),

            (_appNavigator.currentPageIDX == PAGES.PeoplePage.index) ? Padding(
              padding: EdgeInsets.only(right: w*1),
              child: InkWell(
                onTap: (){},
                child: SizedBox(
                  width: w*5,
                  height: w*5,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    child: Icon(Icons.person_add_rounded, size: w*3, color: Colors.white),
                  ),
                ),
              ),
            ) : SizedBox(),

          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Container(
            height: h*4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                InkWell(
                  onTap: ()
                  {
                    if (_appNavigator.currentPageIDX != PAGES.MainPage.index) {
                      _appNavigator.addPage(PAGES.MainPage);
                    }

                  },
                  child: Column(
                    children: [
                      Icon(Icons.chat_bubble, color: getThemeForSelectedNavigationItem(PAGES.MainPage), size: w*4),
                      Text("chats", style: TextStyle(fontSize: h*1, color: getThemeForSelectedNavigationItem(PAGES.MainPage))),
                    ],
                  ),
                ),

                InkWell(
                  onTap: (){
                    if (_appNavigator.currentPageIDX != PAGES.PeoplePage.index) _appNavigator.addPage(PAGES.PeoplePage);
                  },
                  child: Container(
                    width: w*7.5,
                    child: Stack(
                      children: [

                        Column(
                          children: [

                            Icon(Icons.people, color: getThemeForSelectedNavigationItem(PAGES.PeoplePage), size: w*4),

                            Text("People", style: TextStyle(fontSize: h*1, color: getThemeForSelectedNavigationItem(PAGES.PeoplePage))),
                          ],
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withGreen(25),
                              borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.black, width: w*0.3),
                            ),
                            padding: EdgeInsets.all(w*0.2),
                            child: Text("99+", style: TextStyle(fontSize: h*0.8, color: Colors.green, fontWeight: FontWeight.bold)),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        body: _appNavigator.getCurrentPage(),
      ),
    );
  }

  Color getThemeForSelectedNavigationItem (PAGES p)
  {
    if (p.index == _appNavigator.currentPageIDX) return Colors.white;
    else return Colors.grey[600];
  }

}