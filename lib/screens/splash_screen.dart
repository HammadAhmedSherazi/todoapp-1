import '../export_all.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),
        () => Navigator.pushNamed(context, '/LoginScreen'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: pageDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.r,
                width: 100.r,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/app_icon.png'))),
              ),
              18.verticalSpace,
              Text(
                'Todo App',
                style: headingStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
