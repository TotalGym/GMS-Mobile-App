import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/content/store/product.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';

void showProductDialog(Product product) {
  BuildContext context = AppRouter.navKey.currentContext!;
  showDialog(
      barrierColor: const Color.fromARGB(209, 0, 0, 0),
      context: context,
      builder: (context) {
        return _productDialog(product);
      });
}

_productDialog(Product product) {
  return Dialog(
      insetPadding: EdgeInsets.all(24.sp),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(colors: [
            Color(0xef2069D2),
            Color(0xef7C11B1),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        height: 685.h,
        width: 384.w,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(12.sp)),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(
                      height: 256.sp,
                      width: 384.sp,
                      child: Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        height: 256,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      height: 40.sp,
                      decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                          color: Color.fromARGB(198, 6, 16, 31)),
                      child: SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              product.productName.toString().length > 30
                                  ? "${product.productName.toString().substring(0, 29)}.."
                                  : product.productName.toString(),
                              style: TextStyle(
                                  fontSize: 20.sp, color: AppColors.theme1),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 18.sp),
                padding: EdgeInsets.all(18.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.sp),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.theme1Alpha,
                      AppColors.themeAlph,
                      AppColors.theme2Alpha
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Text(
                  product.description ?? "No Description",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.vibrantColor,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 24.sp),
                  padding: EdgeInsets.only(top: 6.sp),
                  height: 165.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.accent, width: 2),
                    borderRadius: BorderRadius.circular(12.sp),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(84, 32, 106, 210),
                        Color.fromARGB(84, 124, 17, 177)
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Price'),
                      Padding(
                        padding: EdgeInsets.only(top: 12.sp),
                        child: Text(
                          product.price.toString(),
                          style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accent,
                              height: 2.sp),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 24.h,
                        width: 140.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8.sp)),
                          color: AppColors.accent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ));
}
