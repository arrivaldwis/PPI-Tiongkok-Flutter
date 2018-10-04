import 'package:mailer/smtp_server.dart';

SmtpServer email(String username, String password) =>
    new SmtpServer('srv39.niagahoster.com', username: username, password: password);