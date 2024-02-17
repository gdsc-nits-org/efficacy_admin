import 'package:intl/intl.dart';

String generatePasswordResetAcknowledgementEmail(
  String appName,
  String username,
  String logoUrl,
) {
  final formattedDate = DateFormat('MMM d, yyyy').format(DateTime.now());

  return '''
<!DOCTYPE html>
<html>
<head>
<title>Password Reset Successful for $appName</title>
<style>
body {
  font-family: sans-serif;
  margin: 0;
  padding: 20px;
  background-color: #f5f5f5;
}

.container {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  text-align: center; /* Center align the entire email content */
}

.logo {
  margin-bottom: 20px;
}

.logo img {
  max-width: 200px;
  height: auto;
}

.header {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 20px;
}

.success-message {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 20px;
}

.instruction {
  font-size: 16px;
  margin-bottom: 20px;
}

.footer {
  font-size: 14px;
  color: #888;
  margin-top: 20px;
}
</style>
</head>
<body>
<div class="container">
  <div class="logo">
    <img src="$logoUrl" alt="$appName logo">
  </div>
  <div class="header">
    Password Reset Successful for $appName
  </div>
  <div class="success-message">
    Hi $username,
    <br>
    Your password for your $appName account has been successfully reset on $formattedDate.
  </div>
  <div class="instruction">
    You can now log in to your account using your new password.
  </div>
  <div class="footer">
    **Important:** If you did not request a password reset, please contact us immediately to report unauthorized access.
  </div>
</div>
</body>
</html>
''';
}
