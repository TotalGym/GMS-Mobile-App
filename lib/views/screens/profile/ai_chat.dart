import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/repositories/ai_chat_repo.dart';
import 'package:gmn/values/assets.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:lottie/lottie.dart';

class OpenAIChat extends StatefulWidget {
  const OpenAIChat({super.key});

  @override
  _OpenAIChatWidgetState createState() => _OpenAIChatWidgetState();
}

class _OpenAIChatWidgetState extends State<OpenAIChat> {
  String _response = '';
  String _prompt = '';
  bool _isLoading = false;
  bool _isChatStarted = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _promptController = TextEditingController();

  void _getResponse(String prompt) async {
    final result = await fetchOpenAIResponse(prompt);
    setState(() {
      if (result.contains('SocketException')) {
        _response = '(!)-> Poor connectoin..\nTry again later';
      } else if (result.contains('Exception') || result.contains('Error')) {
        _response = '(!)-> Something went wrong..\nTry again later';
      } else {
        _response = result;
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold.build(context, _body(), screenTitle: "AI Chat");
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Lottie.asset(Assets.getAnimation(Assets.dumbbells)),
              ),
              !_isChatStarted
                  ? Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _promptController,
                            decoration: const InputDecoration(
                              hintText: 'Say hello or something!',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) => _promptValidator(value),
                          ),
                          SizedBox(height: 20.h),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _prompt = _promptController.text;
                                  _isLoading = true;
                                  _isChatStarted = true;
                                  _promptController.text = '';
                                });
                                _getResponse(_prompt);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 50.sp),
                              alignment: Alignment.center,
                              width: 178.w,
                              height: 55.h,
                              padding: EdgeInsets.all(12.sp),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.theme1,
                                      AppColors.theme2
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.sp)),
                                  color: Colors.green),
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.background),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 330.w,
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.theme1,
                                      AppColors.theme2
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.sp),
                                    bottomLeft: Radius.circular(10.sp),
                                    bottomRight: Radius.circular(10.sp),
                                  ),
                                ),
                                child: SizedBox(
                                  width: 300.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "You:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        _prompt,
                                        style: TextStyle(
                                          color: AppColors.vibrantColor,
                                          fontSize: 16.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 330.w,
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.theme1,
                                      AppColors.theme2
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.sp),
                                    bottomLeft: Radius.circular(10.sp),
                                    bottomRight: Radius.circular(10.sp),
                                  ),
                                ),
                                child: SizedBox(
                                  width: 300.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "AI:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        _isLoading ? "Loading.." : _response,
                                        style: TextStyle(
                                          color: AppColors.vibrantColor,
                                          fontSize: 16.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _prompt = '';
                                  _isChatStarted = false;
                                });
                                // showLoadingDialog();
                                // bool success = await _login(
                                //     emailController.text, passwordController.text);
                                // AppRouter.popFromWidget();

                                // success
                                //     ? AppRouter.navigateWithReplacemtnToWidget(const Home())
                                //     : showFailedLoginSnackBar();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 178.w,
                                height: 55.h,
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.theme1,
                                        AppColors.theme2
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.sp)),
                                    color: Colors.green),
                                child: Text(
                                  "New",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.background),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  String? _promptValidator(String? prompt) {
    if (prompt == null || prompt.isEmpty) {
      return 'Sure you don\'t have something to say?!';
    }

    return null;
  }
}
