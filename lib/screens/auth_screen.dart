import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app1/theme/app_color.dart';
import '../../controllers/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {

  final AuthController controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLogin = true.obs;

  late AnimationController _animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -80,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),

          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: fadeAnimation,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [

                        const SizedBox(height: 40),

                        Text(
                          "SmartNest",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),

                        const SizedBox(height: 40),
                        AnimatedContainer(
                          duration:
                          const Duration(milliseconds: 400),
                          padding:
                          const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 20,
                                offset:
                                const Offset(0, 10),
                              )
                            ],
                          ),
                          child: Obx(() => Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Text(
                                isLogin.value
                                    ? "Welcome Back 👋"
                                    : "Create Account ",
                                style:
                                const TextStyle(
                                  fontSize: 22,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 25),

                              _buildTextField(
                                  emailController,
                                  "Email",
                                  false),

                              const SizedBox(height: 15),

                              _buildTextField(
                                  passwordController,
                                  "Password",
                                  true),

                              const SizedBox(
                                  height: 30),
                              Obx(() => controller
                                  .isLoading.value
                                  ? const Center(
                                child:
                                CircularProgressIndicator(),
                              )
                                  : GestureDetector(
                                onTap: () {
                                  if (emailController
                                      .text
                                      .isEmpty ||
                                      passwordController
                                          .text
                                          .length <
                                          6) {
                                    Get.snackbar(
                                        "Error",
                                        "Enter valid email & password",
                                        backgroundColor:
                                        Colors
                                            .red,
                                        colorText:
                                        Colors
                                            .white);
                                    return;
                                  }

                                  if (isLogin
                                      .value) {
                                    controller
                                        .login(
                                      emailController
                                          .text
                                          .trim(),
                                      passwordController
                                          .text
                                          .trim(),
                                    );
                                  } else {
                                    controller
                                        .signup(
                                      emailController
                                          .text
                                          .trim(),
                                      passwordController
                                          .text
                                          .trim(),
                                    );
                                  }
                                },
                                child:
                                AnimatedContainer(
                                  duration:
                                  const Duration(
                                      milliseconds:
                                      200),
                                  width:
                                  double.infinity,
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                      vertical:
                                      15),
                                  decoration:
                                  BoxDecoration(
                                    gradient:
                                    const LinearGradient(
                                      colors: [
                                        Color(
                                            0xFF0080FF),
                                        Color(
                                            0xFF3399FF),
                                      ],
                                    ),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        18),
                                  ),
                                  child:
                                  Center(
                                    child: Text(
                                      isLogin
                                          .value
                                          ? "Login"
                                          : "Create Account",
                                      style:
                                      const TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        16,
                                        fontWeight:
                                        FontWeight
                                            .w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )),

                              const SizedBox(height: 15),

                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    isLogin.value =
                                    !isLogin
                                        .value;
                                  },
                                  child: Text(
                                    isLogin.value
                                        ? "Don't have an account? Sign Up"
                                        : "Already have account? Login",
                                    style:
                                    const TextStyle(
                                      color: AppColors
                                          .primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.lightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}