import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';

class WorkerKycSectionStatus {
  WorkerKycSectionStatus.fromMap(Map data)
    : stepKey = apiPeramString(
        data['stepKey'] ?? data['sectionType'],
      ).toUpperCase(),
      title = apiPeramString(data['title'], initialValue: 'KYC Step'),
      screenRoute = apiPeramString(data['screenRoute']),
      isCompleted = apiPeramBool(data['isCompleted']),
      canOpen = data['canOpen'] == null ? true : apiPeramBool(data['canOpen']),
      order = apiPeramInt(data['order']),
      status = apiPeramString(data['status']).toUpperCase(),
      remark = apiPeramString(data['remark']);

  final String stepKey;
  final String title;
  final String screenRoute;
  final bool isCompleted;
  final bool canOpen;
  final int order;
  final String status;
  final String remark;

  Map<String, dynamic> toMap() => <String, dynamic>{
    'stepKey': stepKey,
    'title': title,
    'screenRoute': screenRoute,
    'isCompleted': isCompleted,
    'canOpen': canOpen,
    'order': order,
    'status': status,
    'remark': remark,
  };
}

class WorkerKycStatusModel {
  WorkerKycStatusModel.fromResponse(Map response) {
    final Map data = apiPeramMap(response['data']);
    status = apiPeramString(
      data['status'],
      initialValue: 'NOT_STARTED',
    ).toUpperCase();
    final Map progress = apiPeramMap(data['progress']);
    missingDocuments = apiPeramList(
      data['missingDocuments'],
    ).map((item) => apiPeramString(item).toUpperCase()).toList();
    totalSections = apiPeramInt(progress['totalSections']);
    completedSections = apiPeramInt(progress['completedSections']);
    isCompleted = apiPeramBool(progress['isCompleted']);
    sections =
        apiPeramList(
            progress['sections'],
          ).whereType<Map>().map(WorkerKycSectionStatus.fromMap).toList()
          ..sort((a, b) => a.order.compareTo(b.order));
    final Map stepStatus = apiPeramMap(progress['stepStatus']);

    // Always resume from the first incomplete KYC section. A new worker is
    // expected to have missing identity documents, but that must not skip the
    // personal and bank information steps.
    nextStepKey = _firstIncompleteStep(stepStatus);
    if (nextStepKey.isEmpty) {
      nextStepKey =
          sections
              .where((section) => !section.isCompleted && section.canOpen)
              .map((section) => section.stepKey)
              .firstOrNull ??
          '';
    }

    // The backend's explicit navigation fields take priority over the generic
    // missing-document list. A brand-new worker naturally has all documents
    // missing while the correct next screen is still PERSONAL_INFO.
    if (nextStepKey.isEmpty) nextStepKey = _stepKey(progress['nextStep']);
    if (nextStepKey.isEmpty) nextStepKey = _stepKey(progress['pendingStep']);
    if (nextStepKey.isEmpty) nextStepKey = _stepKey(progress['nextSection']);

    // Older status responses may omit all progress navigation fields. Only
    // then use missing documents as the final compatibility fallback.
    if (nextStepKey.isEmpty &&
        missingDocuments.any(
          (item) => item.contains('AADHAAR') || item.contains('PAN_CARD'),
        )) {
      nextStepKey = 'IDENTITY_DOCUMENTS';
    }
    if (nextStepKey.isEmpty &&
        missingDocuments.any((item) => item.contains('LIVE_SELFIE'))) {
      nextStepKey = 'LIVE_SELFIE';
    }
  }

  late final String status;
  late final int totalSections;
  late final int completedSections;
  late final bool isCompleted;
  late final List<String> missingDocuments;
  late final List<WorkerKycSectionStatus> sections;
  late String nextStepKey;

  static String _stepKey(dynamic value) {
    if (value is Map) {
      return apiPeramString(
        value['stepKey'] ?? value['sectionType'],
      ).toUpperCase();
    }
    return apiPeramString(value).toUpperCase();
  }

  static String _firstIncompleteStep(Map stepStatus) {
    const orderedSteps = <String>[
      'PERSONAL_INFO',
      'BANK_INFO',
      'IDENTITY_DOCUMENTS',
      'LIVE_SELFIE',
      'SKILLS_EXPERIENCE',
      'AVAILABILITY',
      'SUBMIT_KYC',
    ];
    for (final step in orderedSteps) {
      if (stepStatus.containsKey(step) && !apiPeramBool(stepStatus[step])) {
        return step;
      }
    }
    return '';
  }
}

int localStepForKycKey(String stepKey) => switch (stepKey.toUpperCase()) {
  'CREATE_KYC' || 'PERSONAL_INFO' => 1,
  'BANK_INFO' => 2,
  'SKILLS_EXPERIENCE' => 6,
  'IDENTITY_DOCUMENTS' => 3,
  'LIVE_SELFIE' => 4,
  'AVAILABILITY' => 7,
  'SUBMIT_KYC' => 8,
  _ => 1,
};
