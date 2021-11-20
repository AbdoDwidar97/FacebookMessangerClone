import 'package:flutter/cupertino.dart';
import 'package:posta/View/Page/MainPage.dart';
import 'package:posta/View/Page/PeoplePage.dart';

enum PAGES
{
  MainPage,
  PeoplePage
}

class AppNavigator with ChangeNotifier
{
  var pagesMap = {
    PAGES.MainPage : MainPage(),
    PAGES.PeoplePage : PeoplePage()
  };

  List<Widget> navPages = [];
  String currentPageTitle = "";
  int currentPageIDX = 0;

  AppNavigator(){
    addPage(PAGES.MainPage);
  }

  setCurrentPageTitle (String title){
    this.currentPageTitle = title;
    notifyListeners();
  }

  setCurrentPageIDX (PAGES p){
    this.currentPageIDX = p.index;
    notifyListeners();
  }

  initPageNavigator (){
    addPage(PAGES.MainPage);
    notifyListeners();
  }

  Widget getCurrentPage () => this.navPages[navPages.length - 1];

  addPage (PAGES p){
    this.navPages.add(pagesMap[p]);
    notifyListeners();
  }

  popUpPage (){
    this.navPages.removeLast();
    notifyListeners();
  }

  popUpAllPages (){
    this.navPages.clear();
    notifyListeners();
  }

}