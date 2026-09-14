enum ProfileType { work, personal, freelancer }

/// Holds everything collected across the 9-step onboarding flow.
/// Passed forward screen-to-screen so later steps can read earlier answers.
class OnboardingData {
  ProfileType? profileType;

  String fullName = '';
  String jobTitle = '';
  String company = '';
  String bio = '';
  String phone = '';
  String email = '';
  String location = '';

  OnboardingData();

  OnboardingData copy() {
    return OnboardingData()
      ..profileType = profileType
      ..fullName = fullName
      ..jobTitle = jobTitle
      ..company = company
      ..bio = bio
      ..phone = phone
      ..email = email
      ..location;
  }
}
