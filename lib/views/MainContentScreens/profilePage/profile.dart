import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crypto_kiosque/models/usermodel.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/utils/errors_messages.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';
import 'package:crypto_kiosque/viewmodels/user_viewmodel.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditingemail = false;
  bool isEditingusername = false;
  bool isEditingtel = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _telcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _pincodecontroller = TextEditingController();

  bool is2FAEnabled = false;
  bool isObscure = false;
  bool isNotificationsEnabled = true;
  String selectedLanguage = 'Français';
  final _userVM = UserViewmodel();
  @override
  void initState() {
    super.initState();

    _emailcontroller = TextEditingController(text: _userVM.currentUser.email);
    _usernamecontroller =
        TextEditingController(text: _userVM.currentUser.username);
    _pincodecontroller =
        TextEditingController(text: _userVM.currentUser.pinCode);
    _telcontroller =
        TextEditingController(text: _userVM.currentUser.tel.toString());
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _usernamecontroller.dispose();
    _telcontroller.dispose();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Center(
            child: Text(
              'Settings',
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
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
                right: 20.0, left: 20.0, top: 10.0), // Marge de 16
            //padding: EdgeInsets.only(top: 10.0), // Padding de 8
            width: 400, height: screenSize.height,
            child: ListView(
              children: [
                ListTile(
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
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
                const ListTile(
                  title: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                              width: 8), // Espace entre l'icône et le texte
                          Text('User Name',
                              style: TextStyle(
                                  color: AppColors.greyText,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _usernamecontroller.text,
                            style: const TextStyle(
                                color: AppColors.greyText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                              width:
                                  8), // Espace entre l'email et l'icône d'édition
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 16,
                              color: AppColors.greyText,
                            ), // Taille de l'icône d'édition
                            onPressed: () {
                              updateInfo(context, "username");
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
                          Icon(Icons.email),
                          SizedBox(
                              width: 8), // Espace entre l'icône et le texte
                          Text('Email',
                              style: TextStyle(
                                  color: AppColors.greyText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _emailcontroller.text,
                            style: const TextStyle(
                                color: AppColors.greyText,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                              width:
                                  8), // Espace entre l'email et l'icône d'édition
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 16,
                              color: AppColors.greyText,
                            ), // Taille de l'icône d'édition
                            onPressed: () {
                              setState(() {
                                isEditingemail = !isEditingemail;
                                updateInfo(context, "email");
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
                          SizedBox(
                              width: 8), // Espace entre l'icône et le texte
                          Text('Phone',
                              style: TextStyle(
                                  color: AppColors.greyText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _telcontroller.text,
                            style: const TextStyle(
                                color: AppColors.greyText,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                              width:
                                  8), // Espace entre l'email et l'icône d'édition
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 16,
                              color: AppColors.greyText,
                            ), // Taille de l'icône d'édition
                            onPressed: () {
                              setState(() {
                                isEditingemail = !isEditingemail;
                                updateInfo(context, "telephone");
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //

                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.lock,
                          ),
                          SizedBox(
                              width: 8), // Espace entre l'icône et le texte
                          Text(
                            'Pincode',
                            style: TextStyle(
                              color: AppColors.greyText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 80,
                            child: Text(
                              isObscure
                                  ? _pincodecontroller.text
                                  : '${_pincodecontroller.text.replaceAll(RegExp(r"."), "⬮")}',
                              style: TextStyle(
                                color: AppColors.greyText,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            icon: isObscure
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 16,
                                    color: AppColors.greyText,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: AppColors.greyText,
                                  ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      SizedBox(
                        width: screenSize.width * 75,
                        height: screenSize.height * .05,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _userVM.logoutUser();
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size(screenSize.width * 0.75, 0),
                            backgroundColor: AppColors.dangerButton,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Logout Account',
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
        ),
      ),
    );
  }

  Future updateInfo(BuildContext context, String scenario) {
    return showModalBottomSheet(
        isScrollControlled: true,
        elevation: 60,
        enableDrag: false,
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();
          switch (scenario) {
            case "username":
              controller = _usernamecontroller;
              break;
            case "email":
              controller = _emailcontroller;
              break;
            case "telephone":
              controller = _telcontroller;
              break;

            default:
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: UpdateWidget(scenario, controller)),
          );
        });
  }

  Widget UpdateWidget(String scenario, TextEditingController controller) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Text(scenario),
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 10, 15),
                child: TextFormField(
                  autofocus: true,
                  validator: (value) {
                    if (controller.text.isEmpty) {
                      return "must enter a new value";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  controller: controller,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: const Text("cancel")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        try {
                          switch (scenario) {
                            case "username":
                              _userVM.updateUser(
                                  username: _usernamecontroller.text,
                                  email: _emailcontroller.text,
                                  tel: int.parse(_telcontroller.text),
                                  pincode: _pincodecontroller.text);
                              break;
                            case "email":
                              _userVM.updateUser(
                                  username: _usernamecontroller.text,
                                  email: _emailcontroller.text,
                                  tel: int.parse(_telcontroller.text),
                                  pincode: _pincodecontroller.text);
                              break;
                            case "telephone":
                              _userVM.updateUser(
                                  username: _usernamecontroller.text,
                                  email: _emailcontroller.text,
                                  tel: int.parse(_telcontroller.text),
                                  pincode: _pincodecontroller.text);
                              break;
                            case "pincode":
                              _userVM.updateUser(
                                  username: _usernamecontroller.text,
                                  email: _emailcontroller.text,
                                  tel: int.parse(_telcontroller.text),
                                  pincode: _pincodecontroller.text);
                              break;
                            default:
                          }
                          Navigator.of(context).pop();
                        } catch (e) {
                          ErrorModal.showErrorDialog(context, e.toString());
                        }
                      },
                      icon: const Text("ok")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
