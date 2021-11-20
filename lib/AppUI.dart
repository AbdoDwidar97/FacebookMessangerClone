import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUI
{
  static Widget textField(BuildContext context, double iWidth, double iHeight, double fontSize, TextEditingController controller, String hint, TextInputType type, Color color, bool isPwd)
  {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(25),
      color: color,
      child: SizedBox(
        width: iWidth,
        height: iHeight,
        child: Center(
          child: TextFormField(
            validator: (val){
              if (val.isEmpty) return "This field is required";
              else return null;
            },
            obscureText: isPwd,
            keyboardType: type,
            maxLines: 1,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              filled: true,
              fillColor: color,
              // isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[900]),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[900]),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.red),
              ),
              suffixStyle: TextStyle(fontSize: fontSize, color: Colors.white),
              errorStyle: TextStyle(height: 0, color: Colors.white),
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: fontSize, color: Colors.grey[500], fontFamily: 'cairo'),
            ),
            style: TextStyle(
                fontSize: fontSize, color: Colors.white, fontFamily: 'cairo'),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
        ),
      ),
    );
  }

  static Widget innerTextField(BuildContext context, double iWidth, double iHeight, double fontSize, TextEditingController controller, String hint, TextInputType type, Color color, bool isPwd, Function onChange, Function onClick)
  {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(25),
      color: color,
      child: SizedBox(
        width: iWidth,
        height: iHeight,
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 50 * 2),
          child: TextFormField(
            validator: (val){
              if (val.isEmpty) return "This field is required";
              else return null;
            },
            onChanged: (val){
              onChange();
            },
            onTap: (){
              onClick();
            },
            obscureText: isPwd,
            keyboardType: type,
            maxLines: 1,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: color,
              // isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[900]),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[900]),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.red),
              ),
              suffixStyle: TextStyle(fontSize: fontSize, color: Colors.white),
              errorStyle: TextStyle(height: 0, color: Colors.white),
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: fontSize, color: Colors.grey[500], fontFamily: 'cairo'),
            ),
            style: TextStyle(
                fontSize: fontSize, color: Colors.white, fontFamily: 'cairo'),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            // textInputAction: TextInputAction.next,
            // onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          ),
        ),
      ),
    );
  }

  static Widget buttonWithPrefix (double iWidth, double iHeight, Color btnColor, Widget widget, Text btnText, Function f)
  {
    return SizedBox(
      width: iWidth,
      height: iHeight,
      child: RaisedButton(
        color: btnColor,
        onPressed: f,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget,
            SizedBox(width: iHeight*0.3),
            btnText
          ],
        ),
      ),
    );
  }

  static Widget iButton (double iWidth, double iHeight, Color btnColor, Text btnText, Function f)
  {
    return SizedBox(
      width: iWidth,
      height: iHeight,
      child: RaisedButton(
        color: btnColor,
        onPressed: f,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: btnText,
      ),
    );
  }

  /*static void showIDialog(BuildContext context, String title, String content)
  {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: title,
          contentText: content,
          positiveText: "Ok",
          onPositiveClick: () {
            Navigator.of(context).pop();
          },
          onNegativeClick: () {
            Navigator.of(context).pop();
          },
        );
      },
      animationType: DialogTransitionType.slideFromTop,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );

  }*/


  static void showAlertDialog(BuildContext buildContext, double titleFontSize, double msgFontSize, String alertDialogTitle, String alertDialogMsg, Function f)
  {

    WidgetsBinding.instance.addPostFrameCallback((_)
    {
      showDialog(
          context: buildContext,
          barrierDismissible: true,
          builder: (BuildContext cont)
          {
            return AlertDialog(
              title: Text(alertDialogTitle, style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'cairo')),
              content: Text(alertDialogMsg, style: TextStyle(fontSize: msgFontSize, color: Colors.black, fontFamily: 'cairo')),
              actions: [
                FlatButton(
                  onPressed: (){
                    Navigator.of(cont).pop();
                    f();
                  },
                  child: Text("Yes", style: TextStyle(fontSize: msgFontSize, color: Colors.black, fontFamily: 'cairo')),
                ),

                FlatButton(
                  onPressed: () => Navigator.of(cont).pop(),
                  child: Text("No", style: TextStyle(fontSize: msgFontSize, color: Colors.black, fontFamily: 'cairo')),
                ),
              ],
            );
          }
      );
    });

  }

}