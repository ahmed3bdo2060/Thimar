part of'bloc.dart';

// final _fakeList = [
//   NotificationModel(id: 0, img: "", title: "تم قبول طلبك وجاري تحضيره الأن", body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى", time: "منذ ساعتان", isRead: true),
//   NotificationModel(id: 1, img: "", title: "رسالة إدارية", body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى", time: "منذ ساعة", isRead: false),
//   NotificationModel(id: 2, img: "", title: "عروض جديدة بإنتظارك", body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى", time: "منذ قليل", isRead: true),
// ];


class NotificationsData {
  late final int unreadCount;
  late final List<NotificationModel> list;

  NotificationsData.fromJson(Map<String, dynamic> json){
    unreadCount = json['unreadnotifications_count']??0;
    list = List.from(json['notifications']??[]).map((e)=>NotificationModel.fromJson(e)).toList();
  }

}
class NotificationModel{
  late final String id,img,title,body,time;
  late final String notifyType;
  late  bool isRead;
  late final Order order;

  NotificationModel.fromJson(Map<String,dynamic>json){
    id = json['id']??"";
    title = json['title']??"";
    body = json['body']??"";
    img = json["image"]??"";
    time = json["created_at"];
    isRead = json[""]??false;
    notifyType = json['notify_type']??"";
    order = Order.fromJson(json['order']??{});
  }

}


class Order {
  late final int orderId;
  late final int clientId;
  late final int driverId;
  late final String orderStatus;

  Order.fromJson(Map<String, dynamic> json){
    orderId = json['order_id']??0;
    clientId = json['client_id']??0;
    driverId = json['driver_id']??0;
    orderStatus = json['order_status']??"";
  }

}
