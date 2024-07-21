import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = 'janedoe@gmail.com';
  String username = '@janedoe';
  String password = 'JDoeDane58';
  bool isEditingemail = false;
  bool isEditingusername = false;
  bool isEditingpassword = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  bool is2FAEnabled = false;
  bool isNotificationsEnabled = true;
  String selectedLanguage = 'Français';

  @override
  void initState() {
    super.initState();
    _emailcontroller = TextEditingController(text: email);
    _usernamecontroller = TextEditingController(text: username);
    _passwordcontroller = TextEditingController(text: password);
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _usernamecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text(
            'Paramètres',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              fontSize: 14,
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
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(
              right: 20.0, left: 20.0, top: 10.0), // Marge de 16
          //padding: EdgeInsets.only(top: 10.0), // Padding de 8
          width: 400,
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  'Langue',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/fr.svg', // Chemin vers votre fichier SVG

                            height: 24,
                          ),
                          const SizedBox(
                              width: 8), // Espace entre le SVG et le texte
                          const Text(
                            'Français',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/en.svg', // Chemin vers votre fichier SVG

                            height: 24,
                          ),
                          const SizedBox(
                              width: 8), // Espace entre le SVG et le texte
                          const Text(
                            'Anglais',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              ListTile(
                title: const Text(
                  'Compte',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    // Espace entre le texte et le bouton
                    SizedBox(
                      width: double
                          .infinity, // Le bouton occupe toute la largeur de l'écran
                      child: ElevatedButton(
                        onPressed: () {
                          // Action pour supprimer le compte
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E4145),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Supprimer son compte',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ListTile(
                title: Text(
                  'Informations personnelles',
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
                                fontFamily: 'Inter',
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
              const Center(
                child: Text(
                  'Powered by Arthur Kemdjo',
                  style: TextStyle(
                      color: Color(0XFF808080),
                      fontSize: 6,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
