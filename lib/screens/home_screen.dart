import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todoapp/export_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();


  @override
  void initState() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // Now you can use your decoded token
    // print(decodedToken);
    userId = decodedToken["_id"];
    // bool isTokenExpired = JwtDecoder.isExpired(token);

    // if (!isTokenExpired) {
    //   Navigator.of(context).pushNamedAndRemoveUntil('/LoginScreen', (Route<dynamic> route) => false);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF64F59),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r))),
        centerTitle: true,
        title: Text(
          'Todo',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 18.sp),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        height: 60.0,
        color: Color(0xffF64F59),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'MainButton',
        onPressed: () {
          showDialog(
              context: context,

              // user must tap button!
              builder: (BuildContext context) {
                return Material(
                  type: MaterialType.transparency,
                  child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.r, vertical: 180.r),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        30.verticalSpace,
                        Text('Add Todo', style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),),
                        Text('Title :', style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp
                        ),),
                        7.verticalSpace,
                        TextWidget(
                          controller: titleTextController,
                          fillColor: Color.fromARGB(255, 240, 196, 210),
                          hintText: "title",
                        )
                      ],
                    ),
                  ),
                ),
                );
              });
        },
        backgroundColor: const Color.fromARGB(209, 119, 51, 48),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // fluter 1.x
      resizeToAvoidBottomInset: false,
      body: const Center(
        child: Text('No Todo Exist!'),
      ),
    );
  }
}
