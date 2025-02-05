import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
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
import '../navigation/navigation_home_screen.dart';
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

    Future<void> saveDeviceToken(String? token) async {
      if (token != null && token.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('deviceToken', token);
        print('Device token saved: $token');
      }
    }

    Future<void> userInfoRequest(String deviceToken) async {
      try {
        UserDetailsResponse response =
            await loginProvider.getUserInfo(deviceToken, context);
        print('User info fetched successfully: ${response.data!.employeeName}');
        print('Response success: ${response.success}');
        print('Response data: ${response.data}');

        if (response.success && response.data != null) {
          setState(() {
            userDetails = response.data!;
          });
          print('User details saved: $userDetails');
          saveDeviceToken(deviceToken);
          Get.offAll(() => NavigationHomeScreen(userDetails: userDetails!));
        } else {
          final errorMessage = loginProvider.cacheRsponse != null
              ? loginProvider.cacheRsponse!.message
              : 'Failed to fetch user info';
          print('Failed to fetch user info: $errorMessage');
          throw errorMessage;
        }
      } catch (error) {
        print('Error fetching user info $error');
      }
    }

    Future<void> handleVerifyOTP() async {
      if (isOTPValidated) {
        try {
          final fcmToken = await getFCMToken();
          if (fcmToken == null) {
            print('FCM token is missing');
          }
          await loginProvider.verifyOTP(_phoneController.text,
              _pinController.text, fcmToken ?? '', context);

          if (loginProvider.loginResponse != null &&
              loginProvider.loginResponse!.success) {
            String deviceToken =
                loginProvider.loginResponse!.data['device_token'];
            await saveDeviceToken(fcmToken);
            await userInfoRequest(deviceToken);
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
            Center(
              child: Image.asset(
                AppAssets.kLogo,
                height: 200,
              ),
            ),
            SizedBox(height: 62.h),
            Text('Sign in', style: AppTypography.kMedium32),
            SizedBox(height: 24.h),
            if (!isOtpVisible) ...[
              Text('Phone Number / User Id', style: AppTypography.kMedium15),
              SizedBox(height: 8.h),
              // Number Field.
              PrimaryContainer(
                padding: EdgeInsets.all(0.h),
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
                          if (value!.isNotEmpty &&
                              value.length >= 10 &&
                              value.length <= 11) {
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
                          : AppColors.kWhite,
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
                defaultPinTheme: PinTheme(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: isDarkMode(context)
                        ? AppColors.kDarkSurfaceColor
                        : AppColors.kWhite,
                    boxShadow: [
                      if (isDarkMode(context))
                        AppColors.darkShadow
                      else
                        AppColors.defaultShadow,
                    ],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && value.length == 6) {
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
                          : AppColors.kWhite,
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
