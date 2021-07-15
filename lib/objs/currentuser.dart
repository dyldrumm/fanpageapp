class CurrentUser {
  static String uid = '';
  static String first = '';
  static String last = '';
  static String email = '';
  static String display = '';

  CurrentUser({required uid});

  static setFirst(String input) {
    first = input;
  }

  static String getFirst() {
    return first;
  }

  static setLast(String input) {
    last = last;
  }

  static String getLast() {
    return last;
  }

  static setEmail(String input) {
    email = input;
  }

  static String getEmail() {
    return email;
  }

  static String getUid() {
    return uid;
  }

  static setUid(String input) {
    uid = input;
  }

  static String getDisplay() {
    return display;
  }

  static setDisplay(String input) {
    display = input;
  }
}
