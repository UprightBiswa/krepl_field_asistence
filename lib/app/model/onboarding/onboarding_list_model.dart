
import '../../data/constrants/constants.dart';

class Onboarding {
  String image;
  String title;
  String description;

  Onboarding(
      {required this.description, required this.image, required this.title});
}

List<Onboarding> onboardingList = [
  Onboarding(
      description:
          'Manage your attendance, TADA expenses, reimbursement, make tour plans for client visits,\norder products for clients, and more!',
      image: AppAssets.kOnboardingFirst,
      title: 'Manage Your Tasks'),
  Onboarding(
      description:
          'Stay connected with fellow employees, receive important updates and announcements, and collaborate efficiently!',
      image: AppAssets.kOnboardingSecond,
      title: 'Connect with Colleagues'),
  Onboarding(
      description:
          'Access all your essential tools and resources in one place, making your work more convenient and productive!',
      image: AppAssets.kOnboardingThird,
      title: 'Access Tools and Resources')
];
