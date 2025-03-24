class Validators {
  bool validateMail(value) {
    RegExp emailString = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    return emailString.hasMatch(value);
  }

  bool validateNumandLetters(value) {
    RegExp numLettersString = RegExp(r"^[A-Za-z0-9\s$%&áéíóú]+$");

    return numLettersString.hasMatch(value);
  }

  bool validateDate(value) {
    RegExp dateString = RegExp(
      r"^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$",
    );
    return dateString.hasMatch(value);
  }
}
