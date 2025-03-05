import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductsIndex extends StatelessWidget {
  const ProductsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.watch<UserProvider>().user!.token;
    if (context.read<ProgramStoreProvider>().products == null) {
      context.read<ProgramStoreProvider>().getAllProducts(token!);
    }

    return Scaffold(
      body: Consumer<ProgramStoreProvider>(
          builder: (context, coachProvider, child) {
        if (coachProvider.products == null) {
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
                        "Product price: ${coachProvider.products!.items![index].price}"),
                  );
                },
                shrinkWrap: true,
                itemCount: coachProvider.products!.items!.length,
              ),
            ),
            InkWell(
              onTap: () {
                context
                    .read<ProgramStoreProvider>()
                    .getProductsNextPage(token!);
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
                context.read<ProgramStoreProvider>().resetProducts();
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
