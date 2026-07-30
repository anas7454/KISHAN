import 'package:constructo_worker/screens/info_content/info_section_model.dart';

/// Static content data for About App, Terms & Conditions, and Privacy Policy screens.
/// Update this file whenever legal content changes — no UI changes needed.
abstract class InfoContentData {
  // ─────────────────────────────────────────────────────────────────────────
  // About App
  // ─────────────────────────────────────────────────────────────────────────
  static const List<InfoSection> aboutApp = [
    InfoSection(
      heading: "About Constructo Worker",
      body:
          "Constructo Worker is a dedicated platform built for skilled construction professionals across India. We connect verified workers — including electricians, plumbers, carpenters, masons, painters, and more — with clients who need quality work done.",
    ),
    InfoSection(
      heading: "Our Mission",
      body:
          "Our mission is to empower every construction worker by giving them access to consistent work opportunities, fair earnings, and a trusted professional identity. We believe every skilled hand deserves recognition and respect.",
    ),
    InfoSection(
      heading: "What We Offer",
      body:
          "• Easy worker registration and profile creation\n"
          "• Access to local job orders and bookings\n"
          "• Real-time order tracking and updates\n"
          "• Secure and transparent payment system\n"
          "• 24/7 customer support for workers\n"
          "• Digital work history and rating system",
    ),
    InfoSection(
      heading: "Why Choose Us",
      body:
          "Constructo Worker is built by people who understand the construction industry. We prioritize your safety, earnings, and professional growth. With our platform, you are not just a worker — you are a verified professional.",
    ),
    InfoSection(
      heading: "Contact Us",
      body:
          "For any queries, feedback, or support, please reach out to us:\n\n"
          "📧 Email: support@constructoworker.in\n"
          "📞 Phone: +91 98765 43210\n"
          "🌐 Website: www.constructoworker.in",
    ),
  ];

  // ─────────────────────────────────────────────────────────────────────────
  // Terms & Conditions
  // ─────────────────────────────────────────────────────────────────────────
  static const List<InfoSection> termsAndConditions = [
    InfoSection(
      heading: "Acceptance of Terms",
      body:
          "By registering and using the Constructo Worker application, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you must not use our application.",
    ),
    InfoSection(
      heading: "Eligibility",
      body:
          "You must be at least 18 years of age and a valid resident of India to register and use Constructo Worker. By using this app, you represent and warrant that you meet all eligibility requirements.",
    ),
    InfoSection(
      heading: "Worker Registration",
      body:
          "Workers must provide accurate, complete, and current information during registration. Any false or misleading information may result in immediate suspension or termination of your account.",
    ),
    InfoSection(
      heading: "Service Usage",
      body:
          "• You may only use this platform for lawful purposes.\n"
          "• You agree not to misrepresent your skills, experience, or certifications.\n"
          "• You must not engage in fraudulent activities or harassment.\n"
          "• Work orders must be completed with professionalism and honesty.",
    ),
    InfoSection(
      heading: "Payments & Earnings",
      body:
          "All payments are processed through our secure payment gateway. Constructo Worker is not responsible for any payment disputes between workers and clients unless facilitated through our in-app payment system.",
    ),
    InfoSection(
      heading: "Account Suspension",
      body:
          "We reserve the right to suspend or terminate your account at any time if you violate these terms, receive repeated negative reviews, or engage in behavior that harms the platform or its users.",
    ),
    InfoSection(
      heading: "Changes to Terms",
      body:
          "Constructo Worker reserves the right to modify these Terms at any time. Updated terms will be posted within the app. Continued use of the app after changes constitutes your acceptance of the new terms.",
    ),
    InfoSection(
      heading: "Governing Law",
      body:
          "These Terms shall be governed by and construed in accordance with the laws of India. Any disputes shall be subject to the exclusive jurisdiction of the courts of India.",
    ),
  ];

  // ─────────────────────────────────────────────────────────────────────────
  // Privacy Policy
  // ─────────────────────────────────────────────────────────────────────────
  static const List<InfoSection> privacyPolicy = [
    InfoSection(
      heading: "Information We Collect",
      body:
          "We collect the following types of information when you register and use Constructo Worker:\n\n"
          "• Personal details: name, phone number, email address, date of birth\n"
          "• Professional details: skills, work experience, certifications\n"
          "• Location data: city, state, working radius\n"
          "• Device information: device type, OS version, app version\n"
          "• Usage data: app interactions and order history",
    ),
    InfoSection(
      heading: "How We Use Your Information",
      body:
          "• To create and manage your worker profile\n"
          "• To match you with relevant job opportunities near you\n"
          "• To process and manage work orders and bookings\n"
          "• To send you notifications about orders and updates\n"
          "• To improve our platform and personalize your experience\n"
          "• To comply with legal and regulatory requirements",
    ),
    InfoSection(
      heading: "Data Sharing",
      body:
          "We do not sell your personal data to third parties. We may share your information with:\n\n"
          "• Clients who book your services through the platform\n"
          "• Payment processors to facilitate transactions\n"
          "• Legal authorities when required by law\n\n"
          "All third-party partners are bound by strict data protection agreements.",
    ),
    InfoSection(
      heading: "Data Security",
      body:
          "We implement industry-standard security measures to protect your personal information, including encrypted data transmission (SSL/TLS), secure server storage, and regular security audits. However, no method of transmission over the internet is 100% secure.",
    ),
    InfoSection(
      heading: "Location Data",
      body:
          "Constructo Worker uses your location to show nearby job opportunities and to display your working radius to potential clients. Location data is only accessed with your explicit permission and is never sold to advertisers.",
    ),
    InfoSection(
      heading: "Your Rights",
      body:
          "You have the right to:\n\n"
          "• Access and review your personal information at any time\n"
          "• Request correction of inaccurate data\n"
          "• Request deletion of your account and personal data\n"
          "• Withdraw consent for data processing at any time\n\n"
          "To exercise these rights, contact us at privacy@constructoworker.in",
    ),
    InfoSection(
      heading: "Cookies & Tracking",
      body:
          "Our app may use analytics tools to track app usage patterns. This data is anonymized and used only to improve user experience. We do not use tracking cookies for advertising purposes.",
    ),
    InfoSection(
      heading: "Changes to This Policy",
      body:
          "We may update this Privacy Policy from time to time. Any changes will be notified via the app. Continued use of the app after updates constitutes your acceptance of the revised policy.",
    ),
    InfoSection(
      heading: "Contact",
      body:
          "For any privacy-related concerns, please contact:\n\n"
          "📧 privacy@constructoworker.in\n"
          "📞 +91 98765 43210",
    ),
  ];
}
