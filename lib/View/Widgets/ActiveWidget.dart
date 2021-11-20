import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta/Model/OnlineFriend.dart';
import 'package:posta/View/ChatScreen.dart';

class ActiveWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => ActiveWidgetState();
}

class ActiveWidgetState extends State <ActiveWidget>
{
  double w, h;

  List<OnlineFriend> onlineFriends = [];

  ActiveWidgetState()
  {
    this.onlineFriends.add(new OnlineFriend(
        name: "Maggie Hershel",
        imageUrl: "https://i.pinimg.com/originals/84/43/29/8443290d1e6036ad931da46c696b837f.png"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Daryl Dixon",
        imageUrl: "https://upload.wikimedia.org/wikipedia/en/d/db/Daryl_Dixon_Norman_Reedus.png"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Sara Tanceradi",
        imageUrl: "https://upload.wikimedia.org/wikipedia/en/4/4f/SaraTancredi.jpg"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "The Professor",
        imageUrl: "https://www.lunigal.com/images/stars/alvaro_morte-2165.jpg"
    ));

    this.onlineFriends.add(new OnlineFriend(
        name: "Sasha B. Adams",
        imageUrl: "https://pbs.twimg.com/profile_images/849735905954975744/ryjVh5Cp_400x400.jpg"
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

    this.onlineFriends.add(new OnlineFriend(
        name: "Michonne Hawthorne",
        imageUrl: "https://tv-fanatic-res.cloudinary.com/iu/s--iHoUSnQt--/t_full/cs_srgb,f_auto,fl_strip_profile.lossy,q_auto:420/v1574581382/michonne-learns-the-truth-the-walking-dead-s10e8.jpg"
    ));
  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return ListView.builder(
      itemCount: this.onlineFriends.length,
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      itemBuilder: (context, idx) {

        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(profileName: this.onlineFriends[idx].name, imgUrl: this.onlineFriends[idx].imageUrl)),
            );
          },
          child: Container(
            width: w*50,
            padding: EdgeInsets.only(top: h*1),
            child: Row(
              children: [

                Stack(
                  children: [

                    SizedBox(
                      width: w*7,
                      height: w*7,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(this.onlineFriends[idx].imageUrl),
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

                SizedBox(width: w*1.5),

                Text(this.onlineFriends[idx].name, style: TextStyle(fontSize: h*1, color: Colors.white)),

              ],
            ),
          ),
        );
      },
    );
  }

}