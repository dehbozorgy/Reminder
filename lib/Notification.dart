
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {

  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future<Uint8List> _downloadFile(String uri) async => (await get(Uri.parse(uri))).bodyBytes;

  static Future _notificationDetails() async {

    final _url1 = "https://panel.kaprila.com/storage/upload/0cff51379f495e3edd98024cd09fc6052787a5f9/2024/09/08/66dd898457eb7.webp";
    final _url2 = "https://cdn.soft98.ir/Auslogics%20Disk%20Defrag.jpg";

    final bigIcon = await _downloadFile(_url1);
    final largIcon = await _downloadFile(_url2);

    final styleInformation = BigPictureStyleInformation(
      ByteArrayAndroidBitmap(bigIcon),
      largeIcon: ByteArrayAndroidBitmap(largIcon),
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
          'channel_Id_1',
          'channel_Name_1',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          sound: UriAndroidNotificationSound("assets/sound/abc.mp3"),
          styleInformation: styleInformation,
          channelDescription: 'channel_Id_1_channel_Name_1',
          groupKey: 'channel_Id_1_channel_Name_1',
          setAsGroupSummary: true,
          // audioAttributesUsage: AudioAttributesUsage.media,
          // channelAction: AndroidNotificationChannelAction.update,
          actions: [
            AndroidNotificationAction('id_Open', 'Open',showsUserInterface: true),
            AndroidNotificationAction('id_Close', 'Close',showsUserInterface: true),
          ]
      ),
    );

  }

  static void _ReceiveNotification(NotificationResponse? PayLoad){

    String? _actionId = PayLoad!.actionId;
    String _actionResult = " actionId => ";

    if(_actionId!=null)
      _actionResult += _actionId;
    else
      _actionResult += "Null";

    print(_actionResult);

    onNotifications.add(PayLoad.payload!+_actionResult);

  }

  @pragma('vm:entry-point')
  static void _ReceiveBackgroundNotification(NotificationResponse? PayLoad){

    String? _actionId = PayLoad!.actionId;
    String _actionResult = " actionId => ";

    if(_actionId!=null)
      _actionResult += _actionId;
    else
      _actionResult += "Null";

    print(_actionResult);

    onNotifications.add(PayLoad.payload!+_actionResult);

  }

  static Future init() async {

    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final setting = InitializationSettings(android: android);

    // When app is Closed
    final details = await _notification.getNotificationAppLaunchDetails();
    if(details!=null && details.didNotificationLaunchApp){
      // onNotifications.add(details.notificationResponse!.payload);
      _ReceiveBackgroundNotification(details.notificationResponse);
    }

    await _notification.initialize(
      setting,
      onDidReceiveNotificationResponse: _ReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: _ReceiveBackgroundNotification,
    );

    // await _notification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestNotificationsPermission();

  }

  static Future showNotification({
    int id=0,
    String? title,
    String? body,
    String? payload})
  async =>
      _notification.show(
          id,
          title,
          body,
          await _notificationDetails(),
          payload: payload
      );

  static Future showScheduledNotification({
    int id=0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate})
  async =>
      _notification.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate,tz.local),
          await _notificationDetails(),
          payload: payload,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        androidScheduleMode: AndroidScheduleMode.exact
      );

  static Future CancellAll() async => await _notification.cancelAll();

  static Future Cancel(int id) async => await _notification.cancel(id);

}