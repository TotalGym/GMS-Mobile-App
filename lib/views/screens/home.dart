import 'package:flutter/material.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String? title;

  const Home({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).checkIfLoggedIn();
    //ignore: avoid_print
    print(
        "this is from build and this is the token: ${Provider.of<UserProvider>(context).token}");
    // Provider.of<TraineeProvider>(context, listen: false).getTrainee();
    // Provider.of<ProgramProvider>(context, listen: false).getAllPrograms();
    // return Consumer<TraineeProvider>(builder: (context, value, child) {
    // value.getTrainee();
    // context.read<UserProvider>().getUser("moha5gmail.com", 'moh123');
    // Provider.of<UserProvider>(context, listen: false)
    //     .logUserIn("moha5@gmail.com", 'moh123');
    // SharePreferencesHelper();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<UserProvider>(
                builder: (context, provider, child) => Text(
                    "${provider.user != null ? provider.user!.email : ""}")),

            Consumer<UserProvider>(
                builder: (context, provider, child) => Text(
                    "${provider.user != null ? provider.token : "token did not found"}")),

            // SizedBox(
            //   height: 150,
            //   width: 150,
            //   child: CachedNetworkImage(
            //     imageUrl:
            //         "https://thebrandhopper.com/wp-content/uploads/2021/10/Product-Innovation.jpg",
            //     progressIndicatorBuilder:
            //         (context, url, downloadProgress) =>
            //             CircularProgressIndicator(
            //                 value: downloadProgress.progress),
            //     errorWidget: (context, url, error) =>
            //         const Icon(Icons.error),
            //   ),
            // ),
            // ListView.builder(
            //   itemBuilder: (context, index) {
            //     return const Text('data');
            //   },
            //   itemCount: 100,
            //   scrollDirection: Axis.vertical,
            // )
          ],
        ),
      ),
    );
  }
}
