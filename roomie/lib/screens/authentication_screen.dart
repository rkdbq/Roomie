import 'package:flutter/material.dart';
import 'package:roomie/authentication.dart';
import 'package:roomie/themes/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum genderTypeEnum { Male, Female }

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final idTextEditingController = TextEditingController();
  final pwTextEditingController = TextEditingController();

  final _authentication = FirebaseAuth.instance;
  bool isSignupScreen = true;
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String userNickName = '';
  String userStudentNumber = '';
  String userEmail = '';
  String userPassword = '';
  genderTypeEnum? _genderTypeEnum;

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('image/jbnu.jpg'),
                          fit: BoxFit.fill)),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 90,
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                              text: 'Welcome to ',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Roomie!',
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                          'Signup to continue',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //배경
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: 250,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.all(20.0),
                  height: isSignupScreen ? 380.0 : 250.0,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '로그인',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen
                                          ? Palette.activeColor
                                          : Palette.textColor1,
                                    ),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '회원가입',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSignupScreen
                                          ? Palette.activeColor
                                          : Palette.textColor1,
                                    ),
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                        if (isSignupScreen) //회원가입
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    //닉네임
                                    key: const ValueKey(1),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 2) {
                                        return '올바른 닉네임을 입력하세요';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userNickName = value!;
                                    },
                                    onChanged: ((value) {
                                      userNickName = value;
                                    }),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: '닉네임',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    //학번
                                    key: const ValueKey(2),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length != 9) {
                                        return '올바른 학번을 입력하세요.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userStudentNumber = value!;
                                    },
                                    onChanged: ((value) {
                                      userStudentNumber = value;
                                    }),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: '학번',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    //이메일
                                    controller: idTextEditingController,
                                    key: const ValueKey(3),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@jbnu.ac.kr')) {
                                        return '올바른 이메일을 입력하세요.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      print("save");
                                      print(value);
                                      userEmail = value!;
                                    },
                                    onChanged: ((value) {
                                      print("change");
                                      print(value);
                                      userEmail = value;
                                    }),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email_rounded,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    //비밀번호
                                    controller: pwTextEditingController,
                                    obscureText: true,
                                    key: const ValueKey(4),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 8) {
                                        return '비밀번호는 8자리 이상이여야 합니다.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: ((value) {
                                      userPassword = value;
                                    }),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  TextFormField(
                                    //비밀번호 확인
                                    obscureText: true,
                                    key: const ValueKey(5),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 8) {
                                        return '비밀번호는 8자리 이상이여야 합니다.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: ((value) {
                                      userPassword = value;
                                    }),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: '비밀번호 확인',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RadioListTile<genderTypeEnum>(
                                          contentPadding:
                                              const EdgeInsets.all(0.0),
                                          value: genderTypeEnum.Male,
                                          groupValue: _genderTypeEnum,
                                          title: Text(genderTypeEnum.Male.name),
                                          onChanged: (val) {
                                            setState(() {
                                              _genderTypeEnum = val;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile<genderTypeEnum>(
                                          contentPadding:
                                              const EdgeInsets.all(0.0),
                                          value: genderTypeEnum.Female,
                                          groupValue: _genderTypeEnum,
                                          title:
                                              Text(genderTypeEnum.Female.name),
                                          onChanged: (val) {
                                            setState(() {
                                              _genderTypeEnum = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (!isSignupScreen) //로그인
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const ValueKey(6),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@jbnu.ac.kr')) {
                                        return '올바른 이메일을 입력하세요.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: ((value) {
                                      userEmail = value;
                                    }),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email_rounded,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  TextFormField(
                                    key: const ValueKey(7),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 8) {
                                        return '올바른 비밀번호를 입력하세요.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: ((value) {
                                      userPassword = value;
                                    }),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Palette.iconColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(35.0),
                                        ),
                                      ),
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              //텍스트
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen ? 590 : 450,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (isSignupScreen) {
                          _tryValidation();

                          try {
                            final newUser = await _authentication
                                .createUserWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );

                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(newUser.user!.uid)
                                .set({
                              'userNickName': userNickName,
                              'email': userEmail,
                              'userStudentNumber': userStudentNumber,
                            });

                            if (newUser.user != null) {
                              print("hi");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Authentication(
                                        email: userEmail,
                                        name: userNickName,
                                        studentNumber: userStudentNumber);
                                  },
                                ),
                              );
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please check your Account and Password',
                                ),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        }
                        if (!isSignupScreen) {
                          _tryValidation();

                          try {
                            final newUser = await _authentication
                                .signInWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );
                            if (newUser.user != null) {
                              print("debug");
                              print(userEmail);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Authentication(
                                      email: userEmail,
                                      name: userNickName,
                                      studentNumber: userStudentNumber,
                                    );
                                  },
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.black,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //전송버튼
            ],
          ),
        ),
      ),
    );
  }
}
