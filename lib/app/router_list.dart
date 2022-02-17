///Todas as rotas da aplicação
class RouterList {

  static const String SPLASH = '/';
  static const String UPDATE_APP = '/update-app';

  ///Signin
  static const String SIGNIN_MODULE = SignRouters.SIGN_IN;
  static const String SIGNIN_USER_PASSWORD = SignRouters.SIGN_IN + SignRouters.SIGN_IN_USER_PASSWORD;
  static const String SIGNUP_USER_DATA = SignRouters.SIGN_IN + SignRouters.SIGN_UP_USER_DATA;

  ///Start
  static const String START_MODULE = StartRouters.START;
  static const String HOME_MODULE = StartRouters.START + HomeRouters.HOME;
  static const String PROFILE_MODULE = StartRouters.START + ProfileRouters.PROFILE;
  static const String MAPTREE_MODULE = StartRouters.START + MapTreeRouters.MAPTREE;
  static const String LEARN_MODULE = StartRouters.START + LearnRouters.LEARN;
  static const String DONATE_MODULE = StartRouters.START + DonateRouters.DONATE;

  ///DONATE
  static const String DONATE_PAYMENT_METHOD = DONATE_MODULE + DonateRouters.PAYMENT_METHOD;
  static const String DONATE_VALUE_PAYMENT = DONATE_MODULE + DonateRouters.VALUE_PAYMENT;
  static const String DONATE_PAY_PIX_BOLETO = DONATE_MODULE + DonateRouters.PAY_PIX_BOLETO;
  static const String DONATE_PERSONAL_DATA = DONATE_MODULE + DonateRouters.PERSONAL_DATA;

  static const String USER_MODULE = UserRouters.USER;
  static const String MAP_MODULE = MapTreeRouters.MAPTREE;

  ///WEB
  static const String WEB_MODULE = RoutersWeb.WEB;
  static const String SIGNIN_WEB_MODULE =WEB_MODULE + RoutersWeb.SIGN_IN;
  static const String START_WEB_MODULE =WEB_MODULE + RoutersWeb.START;
  //Start
  static const String HOME_MODULE_WEB = START_WEB_MODULE + RoutersWeb.HOME;
  static const String TREE_PENDING_MODULE_WEB = START_WEB_MODULE + RoutersWeb.TREE_PENDING;
  static const String CITIES_ACTIVE_MODULE_WEB = START_WEB_MODULE + RoutersWeb.CITIES_ACTIVE;
  static const String STATES_ACTIVE_MODULE_WEB = START_WEB_MODULE + RoutersWeb.STATES_ACTIVE;
  static const String LEARN_MODULE_WEB = START_WEB_MODULE + RoutersWeb.LEARN;
  static const String LEARN_READ_WEB = START_WEB_MODULE + RoutersWeb.LEARN + RoutersWeb.LEARN_READ;
  static const String LEARN_WATCH_WEB = START_WEB_MODULE + RoutersWeb.LEARN + RoutersWeb.LEARN_WATCH;
  static const String USERS_MODULE_WEB = START_WEB_MODULE + RoutersWeb.USERS;
}

//Rotas relativas
class SignRouters {
  static const String SIGN_IN = '/sign-in';
  static const String SIGN_IN_USER_PASSWORD = '/user-password';
  static const String SIGN_UP_USER_DATA = '/sign-up-user-data';
}

//Rotas relativas
class StartRouters {
  static const String START = '/start';
}

//Rotas relativas
class HomeRouters {
  static const String HOME = '/home';
}

class ProfileRouters {
  static const String PROFILE = '/profile';
}

class MapTreeRouters {
  static const String MAPTREE = '/map';
}

class LearnRouters {
  static const String LEARN = '/learn';
}

class DonateRouters {
  static const String DONATE = '/donate';
  static const String PAYMENT_METHOD = '/payment-method';
  static const String VALUE_PAYMENT = '/value-payment';
  static const String PAY_PIX_BOLETO = '/pay-pix-boleto';
  static const String PERSONAL_DATA = '/personal-data';
}

class UserRouters {
  static const String USER = '/user';
}///WEB
class RoutersWeb {
  static const String WEB = '/arbo';
  static const String SIGN_IN = '/sign-in';
  static const String START = '/start';

  ///Tabs
  static const String HOME = '/home';
  static const String TREE_PENDING = '/tree-pending';
  static const String CITIES_ACTIVE = '/cities-active';
  static const String STATES_ACTIVE = '/states-active';
  static const String LEARN = '/learn';
  static const String USERS = '/users';
  static const String LEARN_READ = '/read';
  static const String LEARN_WATCH = '/watch';
}