import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController userNameController;
  late final FocusNode _userNameFocus;
  @override
  void initState() {
    userNameController = TextEditingController();

    _userNameFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();

    _userNameFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: MediaQuery.of(context).size.height * 0.4),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: Row(
                  children: [
                    Text(
                      "Search ",
                      style: GoogleFonts.nunito(
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0069CA)),
                    ),
                    Text(
                      "d_evs",
                      style: GoogleFonts.nunito(
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8C19D2)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: userNameController,
                  focusNode: _userNameFocus,
                  decoration: InputDecoration(
                    label: const Text('Label'),
                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400),
                    hintText: "Search",
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (userNameController.text.isNotEmpty) {
                          Modular.to.pushNamed('/profile/${userNameController.text}');

                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
