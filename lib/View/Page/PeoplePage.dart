import 'package:flutter/material.dart';
import 'package:posta/AppNavigator.dart';
import 'package:posta/View/Widgets/ActiveWidget.dart';
import 'package:posta/View/Widgets/StoriesWidget.dart';
import 'package:provider/provider.dart';

class PeoplePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => PeoplePageState();
}

class PeoplePageState extends State <PeoplePage>
{
  late double w, h;

  late AppNavigator _appNavigator;
  int selectedWidget = 0;

  var searchController = TextEditingController();

  @override
  void initState()
  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)
    {
      Provider.of<AppNavigator>(context, listen: false).setCurrentPageTitle("People");
      Provider.of<AppNavigator>(context, listen: false).setCurrentPageIDX(PAGES.PeoplePage);
    });
  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return Padding(
      padding: EdgeInsets.only(left: w*1, right: w*1),
      child: Column(
        children: [

          SizedBox(height: h*1),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              InkWell(
                onTap: (){
                  setState(() {
                    if (this.selectedWidget != 0) this.selectedWidget = 0;
                  });
                },
                child: Container(
                  width: w*22,
                  padding: EdgeInsets.only(top: h*0.3, bottom: h*0.3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: getColorTheme(0).containerColor,
                  ),
                  child: Text("STORIES (7)", style: TextStyle(fontSize: h*1, color: getColorTheme(0).fontColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ),

              InkWell(
                onTap: (){
                  setState(() {
                    if (this.selectedWidget != 1) this.selectedWidget = 1;
                  });
                },
                child: Container(
                  width: w*22,
                  padding: EdgeInsets.only(top: h*0.3, bottom: h*0.3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: getColorTheme(1).containerColor,
                  ),
                  child: Text("ACTIVE (10)", style: TextStyle(fontSize: h*1, color: getColorTheme(1).fontColor, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ),

              SizedBox(height: h*1),

            ],
          ),

          SizedBox(height: h*1),

          SingleChildScrollView(child: getWidget(this.selectedWidget)),

        ],
      ),
    );
  }

  ColorTheme getColorTheme (int idx)
  {
    if (this.selectedWidget == idx) return ColorTheme(containerColor: Colors.grey[900]!, fontColor: Colors.white);
    else return ColorTheme(containerColor: Colors.black, fontColor: Colors.grey[500]!);
  }

  Widget getWidget (int idx)
  {
    if (idx == 0) return Container(
      width: w*50,
      height: h*36,
      child: StoriesWidget()
    );
    else return Container(
        width: w*50,
        height: h*36,
        child: ActiveWidget()
    );
  }

}

class ColorTheme
{
  Color? containerColor, fontColor;
  ColorTheme({this.containerColor, this.fontColor});
}