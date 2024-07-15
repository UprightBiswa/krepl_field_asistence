
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
          'Plan visits to villages, meet with farmers, onboard new farmers, and demonstrate product usage effectively.',
      image: AppAssets.kOnboardingFirst,
      title: 'Engage with Farmers'),
  Onboarding(
      description:
          'Field assistants can plan and execute sales promotion campaigns, organize product demonstrations, and increase sales.',
      image: AppAssets.kOnboardingSecond,
      title: 'Boost Your Sales'),
  Onboarding(
      description:
          'Build trust among village farmers by showcasing our company’s products and supporting their growth in farming.',
      image: AppAssets.kOnboardingThird,
      title: 'Foster Farmer Trust')
];
