import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta/Model/Story.dart';

class StoriesWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => StoriesWidgetState();
}

class StoriesWidgetState extends State <StoriesWidget>
{
  double w, h;

  List<Story> stories = [];

  StoriesWidgetState ()
  {
    this.stories.add(new Story(
      profileImgUrl: "https://pbs.twimg.com/profile_images/577110013103058944/9nrBmDtj.jpeg",
      storyImgUrl: "https://wallpapercave.com/wp/wp7732702.jpg",
      storiesNumber: 1,
      profileName: "Glenn Rhee"
    ));

    this.stories.add(new Story(
        profileImgUrl: "https://deadline.com/wp-content/uploads/2016/02/scott-wilson-1.jpg",
        storyImgUrl: "https://c4.wallpaperflare.com/wallpaper/578/38/348/tv-show-the-walking-dead-andrew-lincoln-daryl-dixon-wallpaper-preview.jpg",
        storiesNumber: 1,
        profileName: "Hershel T.Johns"
    ));

    this.stories.add(new Story(
        profileImgUrl: "https://i.pinimg.com/originals/a1/51/43/a1514382b1a79e2f7887e75b0f1358ca.png",
        storyImgUrl: "http://2.bp.blogspot.com/-8IgRYQvCPmE/UzAvVZbelaI/AAAAAAAAAjY/0TDFixVYV2o/s1600/andreagunthewalkingdead.png",
        storiesNumber: 1,
        profileName: "Andrea Andrea"
    ));

    // --
    this.stories.add(new Story(
        profileImgUrl: "https://media1.popsugar-assets.com/files/thumbor/_jtQD5J_uAf2zAQ9Zfaa1NP4EAI/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2016/03/17/803/n/1922283/2227b7ca_edit_img_cover_file_17268548_1458238010_TWD_502_GP_0519_0192/i/Carol-Die-Walking-Dead.jpg",
        storyImgUrl: "https://i.pinimg.com/originals/4e/66/25/4e6625b8d8416eb1fff691880cd53a55.jpg",
        storiesNumber: 1,
        profileName: "Carol C"
    ));

    this.stories.add(new Story(
        profileImgUrl: "https://upload.wikimedia.org/wikipedia/en/d/db/Daryl_Dixon_Norman_Reedus.png",
        storyImgUrl: "https://mfiles.alphacoders.com/604/604304.jpg",
        storiesNumber: 1,
        profileName: "Daryl Dixon"
    ));

    this.stories.add(new Story(
        profileImgUrl: "https://i.pinimg.com/originals/84/43/29/8443290d1e6036ad931da46c696b837f.png",
        storyImgUrl: "https://images.hdqwalls.com/download/glenn-maggie-walking-dead-640x960.jpg",
        storiesNumber: 1,
        profileName: "Maggie Hershel"
    ));

    this.stories.add(new Story(
        profileImgUrl: "https://pbs.twimg.com/profile_images/849735905954975744/ryjVh5Cp_400x400.jpg",
        storyImgUrl: "https://c4.wallpaperflare.com/wallpaper/861/127/585/tv-show-the-walking-dead-sasha-williams-sonequa-martin-green-wallpaper-preview.jpg",
        storiesNumber: 1,
        profileName: "Sasha B. Adams"
    ));
  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        mainAxisSpacing: h * 1,
        crossAxisSpacing: h * 1,
        childAspectRatio: (w*21) / (h*13),
        padding: EdgeInsets.only(left: w * 1, right: w * 1),
        children: List.generate(this.stories.length,
                (idx) {
              return Container(
                padding: EdgeInsets.only(top: h*1, bottom: h*1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(this.stories[idx].storyImgUrl),
                    fit: BoxFit.cover
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // SizedBox(height: h*1),

                    SizedBox(
                      width: w*19,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          SizedBox(
                            width: w*4.5,
                            height: w*4.5,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: SizedBox(
                                width: w*4,
                                height: w*4,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(this.stories[idx].profileImgUrl),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: w*3,
                            height: w*3,
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: Text(this.stories[idx].storiesNumber.toString(), style: TextStyle(fontSize: h*0.8, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(
                      width: w*19,
                      child: Text(
                          this.stories[idx].profileName,
                          style: TextStyle(
                          fontSize: h*1,
                          color: Colors.white, fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(w*0.26, w*0.26),
                              blurRadius: 4.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),

                          ],
                        )
                      ),
                    ),

                  ],
                ),
              );
            }));
  }

}