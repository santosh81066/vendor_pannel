import 'dart:convert';

import 'providers/authprovider.dart';
import 'views.dart/addsubscriber.dart';
import 'views.dart/adduser.dart';
import 'views.dart/addvendors.dart';
import 'views.dart/alltransactions.dart';

import 'views.dart/editprofile.dart';
import 'views.dart/editsubscriber.dart';
import 'views.dart/edituser.dart';
import 'views.dart/example.dart';
import 'views.dart/loginpage.dart';

import 'views.dart/uploadcoverpage.dart';
import 'views.dart/uploadphoto.dart';
import 'views.dart/managebookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((value) =>   runApp(const ProviderScope(child: MyApp())));

}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primaryColor: const Color(0xFF6418C3), // Email / Username icon color
        // hintColor: Color(0xFF000), // Used for the 'Delete Plan' button
        // backgroundColor: Color(0xFFE0E0E0), // Background color of input fields
        
        // Define the default font family.
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        

        // Define the default button theme
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF6418c3), // Login button color
          textTheme: ButtonTextTheme.primary,
        ),

        // Other customizations like input decoration, etc.
       
      
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6418c3)),
        useMaterial3: true,
      ),
      // home: Consumer(builder: (context, ref, child) {
      //   final authState=ref.read(authProvider);
      //   print("access_token:${authState.data==null?"": authState.data!.accessToken??""}");
      //   return FutureBuilder(
      //     future:ref.read(authProvider.notifier).isAuthenticated(),
      //     builder: (context, snapshot) {
      //       print('future builder${snapshot.data}');
      //       // Check the authentication status
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         if (snapshot.data == true) {
      //           // If the user is logged in, go to the main page
      //           return  const DashboardWidget();
      //         } else {
      //           // If the user is not logged in, go to the login page
      //           return LoginPage();
      //         }
      //       } else {
      //         // Show a loading spinner while checking authentication status
      //         return const CircularProgressIndicator();
      //       }
      //     },
      //   );}
      // ),
      
      routes:{
        '/': (context) {
                  return Consumer(
                    builder: (context, ref, child) {
                      ref.watch(authProvider);
                     

                      // If the user is not authenticated, attempt auto-login
                      return FutureBuilder(
                        future: ref.read(authProvider.notifier).tryAutoLogin(),
                        builder: (context, snapshot) {
                           print("snapshot data at top of builder:${snapshot.data}");
                        
                            print("snapshot data:${snapshot.data}");
                            // Based on auto-login result, navigate to appropriate screen
                            return snapshot.data == true
                                ? const LoginPage()
                                : AddVendor();
                          
                        },
                      );
                    },
                  );
                },
         'loginpage': (context) => LoginPage(),       
        // // "mainpage":(context) => const MainPage(),
        // "uploadphoto":(context) =>  UploadPhoto(),
        // "coverpage":(context) =>  UploadCoverPage(),
        // "dashboard":(context) =>  const DashboardWidget(),
        // "users":(context) =>  const ManageBookings(),
        // "adduser":(context) =>  const AddUser(),
          "addvendor":(context) =>  const AddVendor(),
        // "edituser":(context) =>  EditUser(),
        // "alltransactions":(context) =>  const AllTransactions(),
        // "editsubscriber":(context) =>   EditSubscriber(),
        // "addsubscriber":(context) =>  const AddSubscriber(),
        // "editprofile":(context) =>  const EditProfile(),
        
      } ,
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
