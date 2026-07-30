class WorkerRegistrationModel {
  // Step 1: Personal Info
  String? fullName;
  String? dob;
  String? gender;
  String? language;
  String? houseNo;
  String? pincode;
  String? state;
  String? city;
  String? fullAddress;
  String? addressProofPath;

  // Step 2: Bank Info
  String? accountHolderName;
  String? accountNumber;
  String? confirmAccountNumber;
  String? ifscCode;
  String? branchName;
  String? passbookProofPath;

  // Step 3: Document's Upload
  String? idFrontPath;
  String? idBackPath;
  String? panCardPath;
  String? policeCertificatePath;

  WorkerRegistrationModel({
    this.fullName,
    this.dob,
    this.gender,
    this.language,
    this.houseNo,
    this.pincode,
    this.state,
    this.city,
    this.fullAddress,
    this.addressProofPath,
    this.accountHolderName,
    this.accountNumber,
    this.confirmAccountNumber,
    this.ifscCode,
    this.branchName,
    this.passbookProofPath,
    this.idFrontPath,
    this.idBackPath,
    this.panCardPath,
    this.policeCertificatePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'dob': dob,
      'gender': gender,
      'language': language,
      'house_no': houseNo,
      'pincode': pincode,
      'state': state,
      'city': city,
      'full_address': fullAddress,
      'address_proof': addressProofPath,
      'account_holder_name': accountHolderName,
      'account_number': accountNumber,
      'ifsc_code': ifscCode,
      'branch_name': branchName,
      'passbook_proof': passbookProofPath,
      'id_front': idFrontPath,
      'id_back': idBackPath,
      'pan_card': panCardPath,
      'police_certificate': policeCertificatePath,
    };
  }
}
