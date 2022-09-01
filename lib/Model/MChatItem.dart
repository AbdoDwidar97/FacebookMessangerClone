import 'package:posta/Model/firebase_models/audio.dart';
import 'package:posta/Model/firebase_models/file_class.dart';

class MChatItem
{
  String? message, receiverPhoto;
  FileClass? imageFile;
  Audio? audio;
  bool? isSender;
  DateTime? timeStamp;

  MChatItem({this.message, this.isSender, this.imageFile, this.audio, this.receiverPhoto, this.timeStamp});

}