class RegistrationSignInReturn {
  late String description; // will be the error code returned by the catch(e.toString())
  late String? flag; // will be null if not error or a non-empty string if error

  RegistrationSignInReturn({required this.description, required this.flag});

  set setDescription(String description) {
    this.description = description;
  }

  set setFlag(String flag) {
    this.flag = flag;
  }
    String get getDescription {
    return description;
  }
  String? get getFlag {
    return flag;
  }
}

