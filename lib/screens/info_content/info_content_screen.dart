import 'package:constructo_worker/screens/info_content/info_section_model.dart';
import 'package:constructo_worker/utils/appbars/appbar_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

/// Reusable screen for About App / Terms & Conditions / Privacy Policy
/// Pass [title] and [sections] to populate the content.
class InfoContentScreen extends StatelessWidget {
  final String title;
  final List<InfoSection> sections;

  const InfoContentScreen({
    super.key,
    required this.title,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      appBar: appBarCustom(title: title),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(16.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...sections.asMap().entries.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: 12.rh),
                    child: _buildSectionCard(
                      index: entry.key + 1,
                      section: entry.value,
                    ),
                  ),
                ),
            sizedboxHeight(24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required int index, required InfoSection section}) {
    final String indexLabel = index.toString().padLeft(2, '0');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.rr),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.rsp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numbered Yellow Badge + Heading Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Yellow Number Badge
              Container(
                width: 32.rw,
                height: 32.rw,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.rr),
                ),
                child: Text(
                  indexLabel,
                  style: AppTextStyles.ts12w500color000000().copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12.rsp,
                    color: AppColors.black,
                  ),
                ),
              ),
              sizedboxWidth(10.rw),
              // Heading
              if (section.heading != null)
                Expanded(
                  child: Text(
                    section.heading!.toUpperCase(),
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.rsp,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
            ],
          ),
          sizedboxHeight(10),
          // Divider
          Container(
            height: 1.rsp,
            color: const Color(0xFFF0F0F0),
          ),
          sizedboxHeight(10),
          // Body Text
          Text(
            section.body,
            style: AppTextStyles.ts14w400color000000().copyWith(
              color: AppColors.color7D7D7D,
              height: 1.65,
              fontSize: 13.rsp,
            ),
          ),
        ],
      ),
    );
  }
}

