import 'package:vendor_pannel/Colors/coustcolors.dart';
import "package:vendor_pannel/widgets/bottomnavigation.dart";
import 'package:vendor_pannel/Providers/auth.dart';
import 'package:vendor_pannel/Screens/addproperty.dart';
import 'package:vendor_pannel/Screens/alltransactions.dart';
import 'package:vendor_pannel/Screens/bookingdetails.dart';
import 'package:vendor_pannel/Screens/dashboard.dart';
import 'package:vendor_pannel/Screens/editprofile.dart';
import 'package:vendor_pannel/Screens/forgotpassword.dart';
import 'package:vendor_pannel/Screens/login.dart';
import 'package:vendor_pannel/Screens/manage.dart';
import 'package:vendor_pannel/Screens/managebookinng.dart';       
import 'package:vendor_pannel/Screens/manageproperty.dart';
import 'package:vendor_pannel/Screens/registration.dart';
import 'package:vendor_pannel/Screens/sales.dart';
import 'package:vendor_pannel/Screens/settings.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:vendor_pannel/Screens/subscription_screen.dart';
import "package:vendor_pannel/Screens/managecalendar.dart";
import "package:vendor_pannel/Screens/calendarpropertieslist.dart";
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
     // Initialize time zones
  tz.initializeTimeZones();
  // await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banquetbookz Vendor',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Roboto', // Set the default font family
          scaffoldBackgroundColor: CoustColors.colrScaffoldbg,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              maximumSize: Size.fromWidth(double.infinity),
              disabledForegroundColor: CoustColors.colrEdtxt4,
              disabledBackgroundColor: CoustColors.colrButton1,
              foregroundColor: CoustColors.colrEdtxt4,
              backgroundColor: CoustColors.colrButton1,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: CoustColors.colrButton3,
            unselectedItemColor: CoustColors.colrSubText,
            type: BottomNavigationBarType.fixed,
          )),
      routes: {
        '/': (context) {
         return Consumer(
              builder: (context, ref, child) {
                final authState = ref.watch(authprovider);
                print('Auth state updated: ${authState.toJson()}');
                // Debugging logs for understanding the state
                print("Auth state data: ${authState.data}");
                print("User Role: ${authState.data?.userRole}");
                print("User Status: ${authState.data?.userStatus}");

                // Check if the user is authenticated and has a valid role and status
                if (authState.data?.userStatus == true &&
                    authState.data?.userRole == "v") {
                  // Navigate to the welcome page if conditions are met
                  return const CoustNavigation(); // Welcome page
                }

                // If the user is not authenticated, attempt auto-login
                return FutureBuilder(
                  future: ref.watch(authprovider.notifier).tryAutoLogin(),
                  builder: (context, snapshot) {
                    print("Auto-login result: ${snapshot.data}");
                    print("Snapshot connection state: ${snapshot.connectionState}");

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator()); // Show SplashScreen while waiting
                    } else {
                      // Navigate based on the auto-login result
                      return snapshot.data == true &&
                              authState.data?.userRole == "v" &&
                              authState.data?.userStatus == true
                          ? const CoustNavigation() // Welcome page
                          : const LoginScreen(); // Login page
                    }
                  },
                );
              },
            );
          },
        '/forgotpwd': (BuildContext context) {
          return const ForgotpasswordScreen();
        },
        '/registration': (BuildContext context) {
          return const RegistrationScreen();
        },
        '/welcome': (BuildContext context) {
          //welcome page
          return const CoustNavigation();
        },
        '/home': (BuildContext context) {
          //welcome page
          return const DashboardScreen();
        },
        '/manage': (BuildContext context) {
          //welcome page
          return const ManageScreen();
        },
        '/sales': (BuildContext context) {
          //welcome page
          return const SalesScreen();
        },
        '/settings': (BuildContext context) {
          //welcome page
          return const SettingsScreen();
        },
        '/managebooking': (BuildContext context) {
          return const ManageBookingScreen();
        },
        '/bookingdetails': (BuildContext context) {
          return const BookingDetailsScreen();
        },
        '/manageproperty': (BuildContext context) {
          return const ManagePropertyScreen();
        },
        '/addproperty': (BuildContext context) {
          return const AddPropertyScreen();
        },
        '/alltransactions': (BuildContext context) {
          return const TransactionsScreen();
        },
        '/editprofile': (BuildContext context) {
          return const EditprofileSceren();
        },
        '/subscriptionScreen': (BuildContext context) {
          return const Subscription();
        },
        '/manageCalendar':(BuildContext context){
          return const ManageCalendarScreen();
        },
        '/calendarPropertiesList':(BuildContext context){
          return const CalendarPropertiesList();
        },
        '/login':(BuildContext context) {
          return const LoginScreen();
        }
      },
    );
  }
}
