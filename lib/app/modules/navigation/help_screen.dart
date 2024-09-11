import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/constrants/constants.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/texts/custom_header_text.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Support',
          style: AppTypography.kMedium15,
        ),
      ),
      backgroundColor:
          isLightMode ? AppColors.kWhite : AppColors.kDarkBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.h),
        child: Column(
          children: <Widget>[
            const CustomHeaderText(text: 'Support'),
            SizedBox(height: 10.h),
            SupportCard(
                onTap: () async {
                  const email =
                      'esupport@krepl.in'; //esupport@krepl.inHelpdesk@krepl.in
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: email,
                  );

                  if (await canLaunchUrl(
                      Uri.parse(emailLaunchUri.toString()))) {
                    await launchUrl(Uri.parse(emailLaunchUri.toString()));
                  } else {
                    throw 'Could not launch $emailLaunchUri';
                  }
                },
                image: AppAssets.kLogo,
                title: 'Email Support',
                subtitle: 'Send us an email at esupport@krepl.in'),
            SizedBox(height: 10.h),
            SupportCard(
              onTap: () async {
                const phoneNumber = '18005725065';
                final Uri phoneLaunchUri = Uri(
                  scheme: 'tel',
                  path: phoneNumber,
                );

                if (await canLaunchUrl(Uri.parse(phoneLaunchUri.toString()))) {
                  await launchUrl(Uri.parse(phoneLaunchUri.toString()));
                } else {
                  throw 'Could not launch $phoneLaunchUri';
                }
              },
              image: AppAssets.kLogo,
              title: 'Call Support',
              subtitle: 'Call our toll-free number 18005725065',
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class SupportCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  const SupportCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PrimaryContainer(
        child: Row(
          children: [
            SizedBox(
              width: 50.w,
              height: 50.h,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.kMedium16),
                  SizedBox(height: 5.h),
                  Text(subtitle,
                      style: AppTypography.kLight14
                          .copyWith(color: AppColors.kHint)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
