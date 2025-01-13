import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController userNameController;
  late final FocusNode userNameFocus;
  final GlobalKey _textFieldKey = GlobalKey();
  List<String> recentSearches = [];
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    userNameFocus = FocusNode()
      ..addListener(() {
        if (userNameFocus.hasFocus && recentSearches.isNotEmpty) {
          _showSuggestions();
        } else {
          _hideSuggestions();
        }
      });
    _loadRecentSearches();
  }

  @override
  void dispose() {
    userNameController.dispose();
    userNameFocus.dispose();
    _hideSuggestions();
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
            vertical: MediaQuery.of(context).size.height * 0.4,
          ),
          child: Column(
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
                        color: const Color(0xFF0069CA),
                      ),
                    ),
                    Text(
                      "d_evs",
                      style: GoogleFonts.nunito(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8C19D2),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  key: _textFieldKey,
                  controller: userNameController,
                  focusNode: userNameFocus,
                  decoration: InputDecoration(
                    label: const Text('Label'),
                    labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400),
                    hintText: "Search",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (userNameController.text.isNotEmpty) {
                          final search = userNameController.text.trim();
                          _saveSearch(search);
                          Modular.to
                              .pushNamed('/profile/${userNameController.text}');
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

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> _saveSearch(String search) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches.remove(search);
      recentSearches.insert(0, search);

      if (recentSearches.length > 5) {
        recentSearches = recentSearches.sublist(0, 5);
      }
    });
    await prefs.setStringList('recentSearches', recentSearches);
  }

  void _showSuggestions() {
    if (overlayEntry != null) return;

    final renderBox =
        _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
    final size = renderBox?.size;
    final offset = renderBox?.localToGlobal(Offset.zero);

    if (size == null || offset == null) return;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          color: Colors.white,
          elevation: 4,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            children: recentSearches
                .map((search) => ListTile(
                      title: Text(search),
                      onTap: () {
                        userNameController.text = search;
                        _hideSuggestions();
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void _hideSuggestions() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
