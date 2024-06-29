// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//API KEYS

//Colors
const Color primaryColor = Color.fromRGBO(227, 2, 111, 1);
const Color blackColor = Colors.black;
const Color blackColor87 = Colors.black87;
const Color blackColor26 = Colors.black26;
const Color blackColor12 = Colors.black12;
const Color whiteColor = Colors.white;
const Color transparentColor = Colors.transparent;
const Color greyColor = Colors.grey;
const Color greenColor = Colors.green;
const Color redColor = Colors.red;
const Color yellowColor = Colors.yellow;
Color pinkColor50 = Colors.pink[50]!;

//Images
const String assetLogo = 'assets/images/logo.png';
const String facebookLogo = 'assets/images/facebook.png';
const String googleLogo = 'assets/images/google.png';
const String appleLogo = 'assets/images/apple.png';
const String habibi = 'assets/images/habibi.png';
const String habibi2 = 'assets/images/habibi2.png';
const String roca = 'assets/images/roca.png';
const String tabom = 'assets/images/tabom.png';
const String dirtyGrill = 'assets/images/dirty_grill.png';
const String bostonsPizza = 'assets/images/bostons_pizza.png';

//SVG
const String facebookIconSVG = 'assets/svg/facebook.svg';
const String googleIconSVG = 'assets/svg/google.svg';
const String appleIconSVG = 'assets/svg/apple.svg';
const String arrowBack = 'assets/svg/arrow-back.svg';
const String menuDrawer = 'assets/svg/menu-drawer.svg';
const String item1 = 'assets/svg/item1.svg';
const String item2 = 'assets/svg/item2.svg';
const String visa = 'assets/svg/visa.svg';

//Strings
const String initSession = 'Iniciar Sesión';
const String userName = 'Username';
const String password = 'Password';
const String name = 'Nombre';
const String email = 'Email';
const String emailRecover = 'Correo electrónico';
const String phone = 'Teléfono';
const String verifyPassword = 'Verificar contraseña';
const String notHaveAccount = '¿No tienes cuenta?';
const String signUp = 'Crear una nueva cuenta';
const String createAccount = 'Crear cuenta';
const String createAccountButton = 'Crear una cuenta';
const String forgotPassword = '¿Olvidaste tu contraseña?';
const String recoverYourAccount = 'Recuperar tu cuenta';
const String recover = 'Reestablecer';
const String recoverAccount = 'Recuperar tu cuenta';
const String haveAccountYet = '¿Ya tienes cuenta?';
const String sessionAppleID = 'Iniciar Sesión con AppleID';
const String sessionGoogle = 'Iniciar Sesión con Google';
const String sessionFacebook = 'Iniciar Sesión con Facebook';
const String titleCodeVerification =
    'Te hemos enviado un código de verificación';
const String subtitleCodeVerification =
    'Hemos enviado un código de verificación a tu email, por favor verifícalo e ingresalo';
const String notHaveCodeVerification =
    '¿No te ha llegado ningún código de verificación?';
const String requestAgain = 'Solicitar nuevamente';
const String helpSupport = '¿Necesitas más ayuda? Contacta a soporte';
const String toastCode = 'Link enviado a tu teléfono';
const String ignoreMessage =
    'Si no solicitaste el cambio de contraseña regresa al ';
const String newPassword = 'Nueva Contraseña';
const String verifyNewPassword = 'Verificar nueva contraseña';
const String changePasswordTitle = 'Cambiar Contraseña';
const String changePasswordButton = 'Cambiar contraseña';
const String returnLogin = 'login';
const String confirmChangePass = 'Cambio de contraseña exitoso!';
const String validateEmail = 'Email no es válido, verifique nuevamente';
const String validatePassword = 'La contraseña no coincide';
const String confirmLogin = 'Se logueo correctamente';
const String errorLogin = 'Error al inciar sesión';
const String warningLogin =
    'Usuario o contraseña incorrectos, revise los datos!';
const String confirmSignUp = 'Registro exitoso, revise su correo';
const String titleHome = 'Historial';
const String STATUS_COMPLETE = 'Completado';
const String STATUS_ERROR = 'Cancelado';
const String STATUS_SHOW = 'Presentado';
const String STATUS_NO_SHOW = 'No Presentado';
const String STATUS_UNDEFINED = 'Undefined';
const String reorder = 'Reordenar';
const String invocie = 'Ver factura';
const String needHepl = '¿Necesitas ayuda?';
const String loadingSession = 'Iniciando sesión...';
const String loadignAccount = 'Registrando...';
const String loading = 'Cargando...';
const String yourOrder = 'Tu pedido';
const String totalArticles = 'Total de artículos';
const String discount = 'Descuento';
const String send = 'Envío';
const String tip = 'Propina';
const String totalPaid = 'Total pagado';
const String paymentMethod = 'Método de pago';
const String typeCard = 'ICIC Bank Card';
const String numCard = '******5486';
const String emptyOrders = 'No hay órdenes';
const String search = 'Buscar...';
String requiredField(String field) => 'El campo $field es requerido';

//Int
const double discountPrice = 172.00;
const double sendPrice = 60.00;
const double tipPrice = 13.00;

//widgets
const verticalSpaceSmall = SizedBox(height: 10);
const verticalSpaceMedium = SizedBox(height: 20);
const verticalSpaceLarge = SizedBox(height: 30);
const verticalSpaceXLarge = SizedBox(height: 40);
const verticalSpaceXXLarge = SizedBox(height: 60);

const horizontalSpaceSmall = SizedBox(width: 10);
const horizontalSpaceMedium = SizedBox(width: 20);
const horizontalSpaceLarge = SizedBox(width: 30);
const horizontalSpaceXLarge = SizedBox(width: 40);

Future<bool?> toast(String title, Color color) async => Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: whiteColor,
      fontSize: 16.0,
    );
