import 'export_all.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          routes: {
            // '/TodoFetchScreen': (context) => const TodoFetchScreen(),
            '/HomeScreen': (context) =>  HomeScreen(),
            '/SplachScreen': (context) => const SplashScreen(),
            '/SignUpScreen': (context) => const SignUpScreen(),
            '/LoginScreen': (context) => const LoginScreen()
          },
          initialRoute: '/SplachScreen',
          debugShowMaterialGrid: false,
        );
      },
    );
  }
}
