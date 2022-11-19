<a href="README.md">
<img src="assets/codeacademy-white.svg" height="42">
</a>

## CodeAcademyChat - iOS Application

#### To start use .xcworkspace, not .xcodeproject

#### User access: 
To register user needs to provide:
- username 
- password
- verification of password

When the user is registering:
- new RSA2048 key pair is created
- private key is saved to UserDefaults (until logout)
- private key encrypted with the provided user password is saved to UserDefaults
- the password is hashed with SHA256

To login user needs to provide:
- username
- password

When the user logins:
- private key is found and decrypted until logout
