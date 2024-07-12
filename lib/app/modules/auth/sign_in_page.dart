import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../provider/login_provider/login_provider.dart';
import '../landing_screens/landing_page.dart';
import '../widgets/animations/shake_animation.dart';
import '../widgets/dividers/custom_vertical_divider.dart';
import '../widgets/widgets.dart';
import 'components/auth_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

String getEmojiFlag(String emojiString) {
  const flagOffset = 0x1F1E6;
  const asciiOffset = 0x41;
  final firstChar = emojiString.codeUnitAt(0) - asciiOffset + flagOffset;
  final secondChar = emojiString.codeUnitAt(1) - asciiOffset + flagOffset;
  return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
}

class _SignInState extends State<SignIn> {
  final TextEditingController _phoneController = TextEditingController();
  late OTPTextEditController _pinController;
  bool isUserIdValidated = false;
  bool isOTPValidated = false;

  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final _shakeOtpKey = GlobalKey<ShakeWidgetState>();
  final FocusNode _pinFocusNode = FocusNode();
  bool isOtpVisible = false;
  late LoginProvider loginProvider;
  UserDetails? userDetails;
  @override
  void initState() {
    super.initState();
    _pinController = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) {
        // Handle received OTP, you can set the received code in your OTP input field
        if (code.isNotEmpty) {
          _pinController.text = code;
        }
      },
    );

    _pinController.startListenUserConsent(
      (code) {
        final exp = RegExp(r'(\d{6})');
        return exp.stringMatch(code ?? '') ?? '';
      },
    );
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // Stop listening for user consent when the widget is disposed
    _pinController.stopListen();
    super.dispose();
  }

  Future<String?> getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    Future<void> handleRequestOTP() async {
      if (isUserIdValidated) {
        try {
          await loginProvider.requestOTP(_phoneController.text, context);
          if (loginProvider.otpRequest != null &&
              loginProvider.otpRequest!.success) {
            setState(() {
              isOtpVisible = true;
            });
          } else {
            final errorMessage = loginProvider.otpRequest != null
                ? loginProvider.otpRequest!.message
                : 'Failed to request OTP';
            throw errorMessage;
          }
        } catch (error) {
          print('Error requesting OTP: $error');
        }
      } else {
        _shakeKey.currentState?.shake();
      }
    }

    Future<void> handleVerifyOTP() async {
      Future<void> userInfoRequest(String username) async {
        try {
          UserDetailsResponse response =
              await loginProvider.getUserInfo(username, context);
          print('User info fetched successfully: ${response.data!.accessType}');
          // if (loginProvider.cacheRsponse != null &&
          //     loginProvider.cacheRsponse!.success &&
          //     response.data != null) {
          //   setState(() {
          //     userDetails = response.data!;
          //   });
          //   print('User details: $userDetails');
          //   Get.offAll(() => LandingPage(userDetails: userDetails!));
          // Additional debug prints
          print('Response success: ${response.success}');
          print('Response data: ${response.data}');

          if (response.success && response.data != null) {
            setState(() {
              userDetails = response.data!;
            });
            print('User details saved: $userDetails');
            Get.offAll(() => LandingPage(userDetails: userDetails!));
          } else {
            // Display an error message if OTP request failed
            final errorMessage = loginProvider.cacheRsponse != null
                ? loginProvider.cacheRsponse!.message
                : 'Failed to fetch user info';
            print('Failed to fetch user info: $errorMessage');
            throw errorMessage;
          }
        } catch (error) {
          // Handle error
          print('Error fetching user info $error');
          // You can display a snackbar or toast to show the error message
        }
      }

      if (isOTPValidated) {
        try {
          final fcmToken = await getFCMToken();
          if (fcmToken == null) {
            print('FCM token is missing');
            // Optionally, handle the missing token case here
          }
          await loginProvider.verifyOTP(_phoneController.text,
              _pinController.text, fcmToken ?? '', context);

          if (loginProvider.loginResponse != null &&
              loginProvider.loginResponse!.success) {
            // Get the user code from the login response
            String username =
                loginProvider.loginResponse!.data['employee_code'];
            await userInfoRequest(username);
          } else {
            final errorMessage = loginProvider.loginResponse != null
                ? loginProvider.loginResponse!.message
                : 'Failed to verify OTP';
            throw errorMessage;
          }
        } catch (error) {
          print('Error verifying OTP: $error');
        }
      } else {
        _shakeOtpKey.currentState?.shake();
      }
    }

    return Scaffold(
      backgroundColor:
          isDarkMode(context) ? AppColors.kDarkBackground : AppColors.kWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.twentyHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h),
            Center(child: Image.asset(AppAssets.kLogo)),
            SizedBox(height: 62.h),
            Text('Sign in', style: AppTypography.kMedium32),
            SizedBox(height: 24.h),
            if (!isOtpVisible) ...[
              Text('Phone Number / User Id', style: AppTypography.kMedium15),
              SizedBox(height: 8.h),
              // Number Field.
              Container(
                decoration: BoxDecoration(
                    color: isDarkMode(context)
                        ? AppColors.kContentColor
                        : AppColors.kInput,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusTen)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getEmojiFlag(
                                'IN'), // Assuming 'IN' is the country code for India
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const CustomVerticalDivider(),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: AuthField(
                        controller: _phoneController,
                        onChanged: (value) {
                          if (value!.isNotEmpty) {
                            setState(() {});
                            isUserIdValidated = true;
                            return value;
                          } else {
                            setState(() {});
                            isUserIdValidated = false;
                            return value;
                          }
                        },
                        hintText: 'Phone Number / User Id',
                        keyboardType: TextInputType.text,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter,
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9]')),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              ShakeWidget(
                key: _shakeKey,
                shakeOffset: 10.0,
                shakeDuration: const Duration(milliseconds: 500),
                child: PrimaryButton(
                  onTap: handleRequestOTP,
                  text: 'Request OTP',
                  color: isUserIdValidated
                      ? null
                      : isDarkMode(context)
                          ? AppColors.kDarkHint
                          : AppColors.kInput,
                ),
              ),
            ],
            if (isOtpVisible) ...[
              Text('Enter OTP', style: AppTypography.kMedium15),
              SizedBox(height: 8.h),
              // OTP Field.
              Pinput(
                length: 6,
                keyboardType: TextInputType.number,
                controller: _pinController,
                focusNode: _pinFocusNode,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      isOTPValidated = true;
                    });
                  } else {
                    setState(() {
                      isOTPValidated = false;
                    });
                  }
                },
              ),
              SizedBox(height: 20.h),
              ShakeWidget(
                key: _shakeOtpKey,
                shakeOffset: 10.0,
                shakeDuration: const Duration(milliseconds: 500),
                child: PrimaryButton(
                  onTap: handleVerifyOTP,
                  text: 'Verify OTP',
                  color: isOTPValidated
                      ? null
                      : isDarkMode(context)
                          ? AppColors.kDarkHint
                          : AppColors.kInput,
                ),
              ),
              SizedBox(height: 63.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextButton(
                      onPressed: () {
                        setState(() {
                          isOtpVisible = false;
                          isUserIdValidated = false; // Reset form validation
                          _phoneController.clear(); // Clear phone number field
                          _pinController.clear(); // Clear OTP field
                        });
                      },
                      text: 'Edit Phone Number',
                      fontSize: 12.sp,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        setState(() {
                          // Clear OTP controller text
                          _pinController.clear();
                        });
                      },
                      text: 'Clear OTP',
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
