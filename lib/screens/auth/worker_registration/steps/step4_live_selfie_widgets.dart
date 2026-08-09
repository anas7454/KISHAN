part of '../worker_registration_widgets.dart';

mixin Step4LiveSelfieWidgets on WorkerRegistrationWidgets {
  Widget liveSelfieVerificationCard({
    required bool isCaptured,
    required WorkerRegistrationController controller,
  }) {
    return sectionCard(
      title: "Face Verification",
      children: [
        sizedboxHeight(8),
        Center(
          child: SizedBox(
            width: 240.rw,
            height: 240.rh,
            child: CustomPaint(
              painter: CornerBracketsPainter(
                color: isCaptured ? const Color(0xff2E7D32) : AppColors.black,
                bracketLength: 36.rw,
                strokeWidth: 2.rsp,
              ),
              child: Center(
                child: SizedBox(
                  width: 200.rw,
                  height: 200.rh,
                  child: Obx(() {
                    final String path = controller.liveSelfiePath.value;
                    final bool hasFile = isCaptured || path.isNotEmpty;

                    return hasFile
                        ? CustomPaint(
                            painter: DottedCircleBorderPainter(
                              color: const Color(0xff2E7D32),
                              strokeWidth: 3.rsp,
                              dotRadius: 2.5.rsp,
                              spacing: 5.rw,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.rw),
                              child: ClipOval(
                                child: path.isNotEmpty && File(path).existsSync()
                                    ? Image.file(
                                        File(path),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          color: AppColors.colorE8E8E8,
                                          child: Icon(Icons.person_rounded,
                                              size: 80.rsp, color: AppColors.black),
                                        ),
                                      ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffD9D9D9),
                              shape: BoxShape.circle,
                            ),
                          );
                  }),
                ),
              ),
            ),
          ),
        ),
        sizedboxHeight(14),
        Obx(() {
          final String path = controller.liveSelfiePath.value;
          final bool isLiveCaptured = isCaptured || path.isNotEmpty;
          return isLiveCaptured
              ? Button(
                  name: "Remove",
                  onPressed: controller.removeLiveSelfie,
                  btnColor: const Color(0xff8D8D8D),
                  textColor: AppColors.white,
                  height: 40.rh,
                  borderRadiusDouble: 100.rh,
                  fontWeight: FontWeight.w600,
                  fontsize: 14.rsp,
                  elevation: 0,
                )
              : Button(
                  name: "Capture Live Photo",
                  onPressed: controller.captureLiveSelfie,
                  btnColor: AppColors.black,
                  textColor: AppColors.white,
                  height: 40.rh,
                  borderRadiusDouble: 100.rh,
                  fontWeight: FontWeight.w600,
                  fontsize: 14.rsp,
                );
        }),
      ],
    );
  }

  // 4 Instruction Guidelines Row (Figma Specs: 30x30px container, 2px radius, #E0E0E0 fill, dotted dividers - Fixed overflow)
  Widget selfieInstructionGuidelines() {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.center_focus_weak_rounded,
        'title': 'Look at\nthe camera',
      },
      {
        'icon': Icons.wb_sunny_outlined,
        'title': 'Use good\nlighting',
      },
      {
        'icon': Icons.block_rounded,
        'title': 'No hat or\nsunglasses',
      },
      {
        'icon': Icons.account_circle_outlined,
        'title': 'Keep your\nface inside\nthe frame',
      },
    ];

    List<Widget> rowChildren = [];
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      rowChildren.add(
        Expanded(
          child: Column(
            children: [
              Container(
                width: 30.rw,
                height: 30.rh,
                decoration: BoxDecoration(
                  color: const Color(0xffE0E0E0), // #E0E0E0 Figma spec
                  borderRadius: BorderRadius.circular(2.rr), // 2px radius
                ),
                child: Icon(
                  item['icon'] as IconData,
                  size: 16.rsp,
                  color: AppColors.black,
                ),
              ),
              sizedboxHeight(8),
              Text(
                item['title'] as String,
                textAlign: TextAlign.center,
                style: AppTextStyles.ts12w500colorBlack().copyWith(
                  fontSize: 10.5.rsp,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );

      if (i < items.length - 1) {
        rowChildren.add(
          SizedBox(
            height: 44.rh,
            width: 1.rw,
            child: CustomPaint(
              painter: DottedVerticalDividerPainter(
                color: const Color(0xffE0E0E0),
                strokeWidth: 1.rsp,
                dashLength: 2.rh,
                dashGap: 3.rh,
              ),
            ),
          ),
        );
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowChildren,
    );
  }

  // Step 4: Live Selfie Verification (Uncaptured)
  Widget step4LiveSelfie(WorkerRegistrationController controller) {
    return Column(
      children: [
        liveSelfieVerificationCard(isCaptured: false, controller: controller),
        sizedboxHeight(24),
        selfieInstructionGuidelines(),
      ],
    );
  }

  // Step 5: Live Selfie Verification (Captured)
}

