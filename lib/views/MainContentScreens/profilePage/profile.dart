import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crypto_kiosque/models/usermodel.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  RecordModel? _model = Server().server.authStore.model;
  UserModel? _user;
  String email = 'janedoe@gmail.com';
  String username = '@janedoe';
  String password = 'JDoeDane58';
  String tel = "+237690462556";
  bool isEditingemail = false;
  bool isEditingusername = false;
  bool isEditingpassword = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _telcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  bool is2FAEnabled = false;
  bool isNotificationsEnabled = true;
  String selectedLanguage = 'Français';

  @override
  void initState() {
    super.initState();
    _user = UserModel.userGenerator(_model!.data);

    _emailcontroller = TextEditingController(text: email);
    _usernamecontroller = TextEditingController(text: username);
    _passwordcontroller = TextEditingController(text: password);
    _telcontroller = TextEditingController(text: tel);
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _usernamecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  XFile? _image;
  final picker = ImagePicker();
  void getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text(
            'Paramètres',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Container(
            color: Color(0xFFE6E6E6),
            height: 0.5,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
            right: 20.0, left: 20.0, top: 10.0), // Marge de 16
        //padding: EdgeInsets.only(top: 10.0), // Padding de 8
        width: 400, height: screenSize.height,
        child: ListView(
          children: [
            ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: screenSize.width * 0.4,
                  height: screenSize.width * 0.4,
                  child: FittedBox(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: _image != null
                              ? FileImage(File(_image!.path), scale: 1)
                              : const AssetImage("assets/images/user.png")
                                  as ImageProvider<Object>?,
                        ),
                        Positioned(
                            top: 100,
                            left: 105,
                            child: IconButton(
                              onPressed: getImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                size: 30,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ListTile(
              title: Text(
                'Personal Information',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 8), // Espace entre l'icône et le texte
                      Text('Email',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      isEditingemail
                          ? Container(
                              width: 140, // Largeur du champ de texte
                              child: TextField(
                                controller: _emailcontroller,
                                onSubmitted: (value) {
                                  setState(() {
                                    email = value;
                                    isEditingemail = false;
                                  });
                                },
                              ),
                            )
                          : Text(
                              email,
                              style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            ),
                      SizedBox(
                          width:
                              8), // Espace entre l'email et l'icône d'édition
                      IconButton(
                        icon: Icon(Icons.edit,
                            size: 16), // Taille de l'icône d'édition
                        onPressed: () {
                          setState(() {
                            isEditingemail = !isEditingemail;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //
            const SizedBox(height: 8),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8), // Espace entre l'icône et le texte
                      Text('phone',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      isEditingemail
                          ? Container(
                              width: 140, // Largeur du champ de texte
                              child: TextField(
                                controller: _telcontroller,
                                onSubmitted: (value) {
                                  setState(() {
                                    tel = value;
                                    isEditingemail = false;
                                  });
                                },
                              ),
                            )
                          : Text(
                              tel,
                              style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            ),
                      SizedBox(
                          width:
                              8), // Espace entre l'email et l'icône d'édition
                      IconButton(
                        icon: Icon(Icons.edit,
                            size: 16), // Taille de l'icône d'édition
                        onPressed: () {
                          setState(() {
                            isEditingemail = !isEditingemail;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //

            const SizedBox(height: 8),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: 8), // Espace entre l'icône et le texte
                      Text('Nom d\'utilisateur',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'Inter',
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      isEditingusername
                          ? Container(
                              width: 80, // Largeur du champ de texte
                              child: TextField(
                                controller: _usernamecontroller,
                                onSubmitted: (value) {
                                  setState(() {
                                    username = value;
                                    isEditingusername = false;
                                  });
                                },
                              ),
                            )
                          : Text(
                              username,
                              style: TextStyle(
                                  color: Color(0XFF808080),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            ),
                      SizedBox(
                          width:
                              8), // Espace entre l'email et l'icône d'édition
                      IconButton(
                        icon: Icon(Icons.edit,
                            size: 16), // Taille de l'icône d'édition
                        onPressed: () {
                          setState(() {
                            isEditingusername = !isEditingusername;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ListTile(
              title: Text(
                'Sécurité',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lock),
                      SizedBox(width: 8), // Espace entre l'icône et le texte
                      Text(
                        'Mot de passe',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      isEditingpassword
                          ? Container(
                              width: 70, // Largeur du champ de texte
                              child: TextField(
                                controller: _passwordcontroller,
                                obscureText:
                                    false, // Affiche la valeur réelle du mot de passe lors de l'édition
                                onSubmitted: (value) {
                                  setState(() {
                                    password = value;
                                    isEditingpassword = false;
                                  });
                                },
                              ),
                            )
                          : Text(
                              '***********', // Affiche des astérisques lorsque le mot de passe n'est pas en mode d'édition
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      SizedBox(width: 8), // Espace entre l'icône et le texte
                      IconButton(
                        icon: Icon(Icons.edit,
                            size: 16), // Taille de l'icône d'édition
                        onPressed: () {
                          setState(() {
                            isEditingpassword = !isEditingpassword;
                            if (isEditingpassword) {
                              _passwordcontroller.text =
                                  password; // Met à jour le TextField avec la valeur réelle
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
                leading: Icon(Icons.security),
                title: Text(
                  '2FA Authentification',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 0.5, // Ajustez cette valeur pour changer la taille
                  child: Switch(
                    value: is2FAEnabled,
                    onChanged: (value) {
                      setState(() {
                        is2FAEnabled = value;
                      });
                    },
                  ),
                )),
            SizedBox(height: 14),
            ListTile(
              title: Text(
                'Notifications',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Activer',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Radio(
                        value: true,
                        groupValue: isNotificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            isNotificationsEnabled = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Désactiver',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Radio(
                        value: false,
                        groupValue: isNotificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            isNotificationsEnabled = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Espace entre le texte et le bouton
                  SizedBox(
                    width: screenSize.width * 75,
                    height: screenSize.height * .05,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action pour supprimer le compte
                      },
                      style: ElevatedButton.styleFrom(
                        // fixedSize: Size(screenSize.width * 0.75, 0),
                        backgroundColor: AppColors.dangerButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Supprimer son compte',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
