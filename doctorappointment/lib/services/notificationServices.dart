import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
class NotificationService {
  

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

     final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/logo');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
              
            });
            
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
  
    //  onSelectNotification:onSelectNotification,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
              
            });
            // String? pay;
              onSelectNotification:onSelectNotification;
                // onSelectNotification(pay);
   }
  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }
  Future showNotification(
      {required int id, 
      required String? title, 
      required String? body, 
      required String? payload
      }) async {
    return notificationsPlugin.show(
        id, title, body,await notificationDetails());
  }
void onSelectNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
     }
  }

}