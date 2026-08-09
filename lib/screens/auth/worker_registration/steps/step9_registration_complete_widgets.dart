part of '../worker_registration_widgets.dart';

mixin Step9RegistrationCompleteWidgets on WorkerRegistrationWidgets {
  Widget registrationSuccessIllustration() {
    return SizedBox(
      width: 170.rw,
      height: 150.rh,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Outer soft green circle ring 1 (134x134px Figma spec)
          Container(
            width: 134.rw,
            height: 134.rh,
            decoration: const BoxDecoration(
              color: Color(0xffEBF7EE), // #EBF7EE soft green Figma spec
              shape: BoxShape.circle,
            ),
          ),
          // Inner soft green circle ring 2 (94x94px Figma spec)
          Container(
            width: 94.rw,
            height: 94.rh,
            decoration: const BoxDecoration(
              color: Color(0xffD5EFDC), // #D5EFDC medium green Figma spec
              shape: BoxShape.circle,
            ),
          ),
          // Solid green center circle with white check icon (56x56px Figma spec)
          Container(
            width: 56.rw,
            height: 56.rh,
            decoration: const BoxDecoration(
              color: Color(0xff2EAD42), // #2EAD42 green Figma spec
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: AppColors.white,
              size: 32.rsp,
            ),
          ),
          // Floating green sparkles around illustration
          Positioned(
            top: 4.rh,
            left: 28.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 10.rsp),
          ),
          Positioned(
            top: 2.rh,
            right: 42.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 8.rsp),
          ),
          Positioned(
            top: 32.rh,
            right: 8.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 16.rsp),
          ),
          Positioned(
            bottom: 28.rh,
            left: 8.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 14.rsp),
          ),
          Positioned(
            bottom: 8.rh,
            right: 32.rw,
            child: Icon(Icons.star_rounded, color: const Color(0xff2EAD42), size: 10.rsp),
          ),
        ],
      ),
    );
  }

  Widget registrationInfoCard({
    required String title,
    required String subtitlePrefix,
    required String highlightText,
    required String subtitleSuffix,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.rh),
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh), // Top/Bottom: 12px, Left/Right: 16px Figma spec
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.ts14w600colorBlack().copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          sizedboxHeight(6), // 6px gap Figma spec
          RichText(
            text: TextSpan(
              style: AppTextStyles.ts12w500color808080().copyWith(
                color: AppColors.color7D7D7D,
                fontSize: 12.rsp,
                height: 1.3,
              ),
              children: [
                TextSpan(text: subtitlePrefix),
                if (highlightText.isNotEmpty)
                  TextSpan(
                    text: highlightText,
                    style: const TextStyle(
                      color: Color(0xff16A34A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (subtitleSuffix.isNotEmpty) TextSpan(text: subtitleSuffix),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget step9RegistrationComplete(WorkerRegistrationController controller) {
    return Column(
      children: [
        sizedboxHeight(8),
        Center(child: registrationSuccessIllustration()),
        sizedboxHeight(12),
        Text(
          "Registration Successful!",
          textAlign: TextAlign.center,
          style: AppTextStyles.ts18w700color000000().copyWith(
            fontSize: 20.rsp,
            fontWeight: FontWeight.w800,
          ),
        ),
        sizedboxHeight(8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.rw),
          child: Text(
            "Congratulations! Your application has been submitted successfully. We will review your information and get back to you soon.",
            textAlign: TextAlign.center,
            style: AppTextStyles.ts12w500color808080().copyWith(
              color: AppColors.color7D7D7D,
              fontSize: 12.rsp,
              height: 1.4,
            ),
          ),
        ),
        sizedboxHeight(20),
        // Your Application ID Card (Figma Specs: Frame 2147227006, 360x60px Hug, Radius: 8px, Gap: 6px)
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.rw), // 12px padding Figma spec
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
            border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp), // 1px #DBDBDB
          ),
          child: Row(
            children: [
              Container(
                width: 36.rw,
                height: 36.rh,
                decoration: BoxDecoration(
                  color: const Color(0xff16A34A).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.rr),
                ),
                child: Icon(
                  Icons.badge_outlined,
                  color: const Color(0xff16A34A),
                  size: 20.rsp,
                ),
              ),
              sizedboxWidth(6), // 6px gap Figma spec
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Application ID",
                    style: AppTextStyles.ts12w500color808080().copyWith(
                      fontSize: 11.rsp,
                      height: 1.2,
                    ),
                  ),
                  sizedboxHeight(2),
                  Text(
                    "APP2026072200001",
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      color: const Color(0xff16A34A),
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5.rsp,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        sizedboxHeight(16),
        // 4 Status Timeline Cards
        registrationInfoCard(
          title: "Application Review",
          subtitlePrefix: "Our team will review your application within ",
          highlightText: "2 - 3 working days.",
          subtitleSuffix: "",
        ),
        registrationInfoCard(
          title: "Verification & Communication",
          subtitlePrefix: "We may contact you for any additional information if required.",
          highlightText: "",
          subtitleSuffix: "",
        ),
        registrationInfoCard(
          title: "Application Status Update",
          subtitlePrefix: "You will receive updates on your application status via ",
          highlightText: "SMS and Email",
          subtitleSuffix: "",
        ),
        registrationInfoCard(
          title: "Approval & Onboarding",
          subtitlePrefix: "Once approved, you can start your journey with us!",
          highlightText: "",
          subtitleSuffix: "",
        ),
        sizedboxHeight(4),
        // Need Help Card (Figma Specs: Profile Container, 360x64px Hug, Radius: 8px, #F6FAFE fill, #EEEEEE border)
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 12.rh, bottom: 12.rh, left: 16.rw, right: 21.rw), // Figma padding: Top 12, Right 21.18, Bottom 12, Left 15.88
          decoration: BoxDecoration(
            color: const Color(0xffF6FAFE), // #F6FAFE fill Figma spec
            borderRadius: BorderRadius.circular(8.rr), // 8px radius Figma spec
            border: Border.all(color: const Color(0xffEEEEEE), width: 1.rsp), // 1.06px #EEEEEE border Figma spec
          ),
          child: Row(
            children: [
              Container(
                width: 38.rw,
                height: 38.rh,
                decoration: const BoxDecoration(
                  color: Color(0xffD9E8FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.headset_mic_rounded,
                  color: const Color(0xff1E88E5),
                  size: 20.rsp,
                ),
              ),
              sizedboxWidth(8), // 8.47px gap Figma spec
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Need Help?",
                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5.rsp,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Our support team is here to help you.",
                      style: AppTextStyles.ts12w500color808080().copyWith(
                        fontSize: 11.5.rsp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.black,
                size: 20.rsp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

