import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/models/user.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  static const routeName ='home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instancias para la autenticación y API de la cuenta
  final AuthenticationClient _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _accountAPI = GetIt.instance<AccountAPI>();
  // Usuario actual
  late User _user; 

  @override
  void initState(){
    super.initState();

    // Cargar información del usuario al iniciar la página
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _loaduser();
    });
  }

  // Método para cargar la información del usuario
  Future<void> _loaduser() async {
    final response = await _accountAPI.getUserInfo();
    if(response.data != null){
      _user = response.data;
      setState(() {});
    }
  }

  // Método para cerrar sesión
  Future<void> _SignOut() async {
    await _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context as BuildContext, 
      LoginPage.routeName, 
      (_) => false
    );
  }

  // Método para seleccionar una imagen de la cámara y actualizarla
  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final PickedFile pickedFile = (await imagePicker.pickImage(source: ImageSource.camera)) as PickedFile;
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final filename = path.basename(pickedFile.path);
      final response = await _accountAPI.updateAvatar(bytes, filename);
      if (response.data != null) {
        _user = _user.copyWith(
          avatar: response.data, 
          id: '', 
          username: '', 
          email: '', 
          createdAt: response.data.createdAt ?? DateTime.now(), 
          updatedAt: response.data.updatedAt ?? DateTime.now()
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Indicador de carga si el usuario no está cargado
            if(_user == null) CircularProgressIndicator(),
            // Mostrar información del usuario si está cargado
            if(_user!=null) Column(
              children: [
                // Mostrar avatar si está disponible
                if (_user.avatar != null)
                  ClipOval(
                    child: Image.network(
                      "http://127.0.0.1:9000${_user.avatar}",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                // Mostrar detalles del usuario
                Text(_user.id),
                Text(_user.username),
                Text(_user.email),
                Text(_user.createdAt.toIso8601String())
              ],
            ),
            // Botón para actualizar la imagen
            CupertinoButton(
              child: Text("update image"), 
              onPressed: _pickImage 
            ),
            // Botón para cerrar sesión
            CupertinoButton(
              child: Text("sign out"), 
              onPressed: _SignOut 
            )
          ],
        ),
      ),
    );
  }
}
