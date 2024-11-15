import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'ModelDataBase/TableReminder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'PageReminder/PageReminder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Notification.dart';
import 'SecondPage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'DataBase.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationApi.init();

  await Hive
    ..initFlutter()
    ..registerAdapter(TableReminderAdapter())
  ;

  await ScreenUtil.ensureScreenSize();

  Permission.notification.isDenied.then((value){
    if(value){
      Permission.notification.request();
    }
  });

  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: const Locale("fa", "IR"),
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      localizationsDelegates: const [
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
        // DariMaterialLocalizations.delegate, Dari
        // DariCupertinoLocalizations.delegate,
        // PashtoMaterialLocalizations.delegate, Pashto
        // PashtoCupertinoLocalizations.delegate,
        // SoraniMaterialLocalizations.delegate, Kurdish
        // SoraniCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationApi.init();


    ListenNotifications();

  }

  void ListenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=> SecondPage(Payload: payload)
      ));

  List<String> newId = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Builder(builder: (context){
            ScreenUtil.init(context, designSize: const Size(360, 690));
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PageReminder()));
                  },
                  child: Text('Page Reminder',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      )
                  ),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent)
                  ),
                ),
                const SizedBox(height: 20),


                ElevatedButton(
                  onPressed: () async {
                    await DeletAll();
                  },
                  child: Text('Delete All',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      )
                  ),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent)
                  ),
                ),
                const SizedBox(height: 20),



                // ElevatedButton(
                //     onPressed: (){
                //       NotificationApi.showNotification(title: 'Show Notification',body: 'Navid Bozorgi',payload: 'Navid.Bozorgi');
                //     },
                //     child: Text('Simple Notification'),
                // ),
                // const SizedBox(height: 20),
                //
                // ElevatedButton(
                //   onPressed: (){
                //
                //     DateTime OldDate = DateTime.now();
                //
                //     // DateTime newDate = DateTime(OldDate.year,OldDate.month,OldDate.day+1,OldDate.hour,OldDate.minute+2,OldDate.second);
                //     // NotificationApi.showScheduledNotification(scheduledDate: newDate,title: 'Navid',body: 'Bozorgi',payload: 'Navid.Bozorgi');
                //
                //     DateTime newDate = OldDate.add(Duration(seconds: 20));
                //
                //     String _StringDate = newDate.toString();
                //
                //     newId.add(_StringDate);
                //
                //     print('StringDate => $_StringDate');
                //
                //     int _intDate = _StringDate.hashCode;
                //
                //     print('_intDate => $_intDate');
                //
                //     NotificationApi.showScheduledNotification(id: _intDate,scheduledDate: newDate,title: 'Scheduled Notification',body: 'Navid Bozorgi At Date => $_StringDate',payload: 'Navid.Bozorgi');
                //
                //     },
                //   child: Text('Scheduled Notification'),
                // ),
                // const SizedBox(height: 20),
                //
                //
                // ElevatedButton(
                //   onPressed: () {
                //     NotificationApi.CancellAll();
                //   },
                //   child: Text('Cancel All'),
                // ),
                // const SizedBox(height: 20),
                //
                // ElevatedButton(
                //   onPressed: () {
                //     NotificationApi.Cancel(newId.last.hashCode);
                //   },
                //   child: Text('Last Cancel'),
                // ),
                // const SizedBox(height: 20),
                //
                // ElevatedButton(
                //   onPressed: () {
                //     NotificationApi.Cancel(newId.first.hashCode);
                //   },
                //   child: Text('First Cancel'),
                // ),
                // const SizedBox(height: 20),

              ],
            );
          })
        ),
      ),
    );
  }

}
