extension ExtString on String {
  String? get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (isEmpty && true) {
      return "El correo es obligatorio";
    }
    if (emailRegExp.hasMatch(this)) {
      return null;
    } else {
      return "No es un email valido";
    }
  }

  String? get isValidPassword {
    if (isEmpty && true) {
      return "El contraseña es obligatoria";
    }
    if (length >= 6) return null;
    return "La longitud debe de ser de 6 caracteres";
  }

  String? get notEmpty {
    if (isEmpty && true) {
      return "El campo es obligatorio";
    } else {
      return null;
    }
  }
}
