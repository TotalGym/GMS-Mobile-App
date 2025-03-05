import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProgramsIndex extends StatelessWidget {
  const ProgramsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.watch<UserProvider>().user!.token;
    if (context.read<ProgramStoreProvider>().programs == null) {
      context.read<ProgramStoreProvider>().getAllPrograms(token!);
    }

    return Scaffold(
      body: Consumer<ProgramStoreProvider>(
          builder: (context, coachProvider, child) {
        if (coachProvider.programs == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 150.sp,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Text(
                        "Program price: ${coachProvider.programs!.items![index].description}"),
                  );
                },
                shrinkWrap: true,
                itemCount: coachProvider.programs!.items!.length,
              ),
            ),
            InkWell(
              onTap: () {
                context
                    .read<ProgramStoreProvider>()
                    .getProgramsNextPage(token!);
              },
              child: Container(
                alignment: Alignment.center,
                width: 150.sp,
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    color: Colors.blue),
                child: const Text(
                  "Load More!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.read<ProgramStoreProvider>().resetPrograms();
              },
              child: Container(
                alignment: Alignment.center,
                width: 150.sp,
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    color: Colors.red[400]),
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
