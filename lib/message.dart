class Message {
  int id;
  String name;
  List<Frame> frames = [];
}

class Frame {
  int id;
  String name;
  bool isReg;
  int maxCountReg;
  int countBufReg;
}

List<Message> getMessagesFromJson(dynamic json) {
  if (json == null) {
    return null;
  }
  List<Message> messages = [];
  final dynamic objReg = json['objReg'];
  if (objReg != null && objReg is List) {
    for (dynamic message in objReg) {
      messages.add(getMessageFromJson(message));
    }
  }
  return messages;
}

Message getMessageFromJson(dynamic json) {
  if (json == null) {
    return null;
  }
  Message message = Message();
  message.name = json['name'];
  message.id = json['idObj'];
  final dynamic objReg = json['kadrs'];
  if (objReg != null && objReg is List) {
    for (dynamic frame in objReg) {
      message.frames.add(getFrameFromJson(frame));
    }
  }
  return message;
}

Frame getFrameFromJson(dynamic json) {
  Frame frame = Frame();
  frame.id = json['idKadr'];
  frame.name = json['name'];
  frame.isReg = json['isReg'];
  frame.maxCountReg = json['maxCountReg'];
  frame.countBufReg = json['countBufReg'];
  return frame;
}
