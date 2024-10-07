import 'package:flutter/material.dart';
import 'package:tres_astronautas/presentation/widgets/search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSearch;

  const CustomAppBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
        child: Center(
          child: Text(
            'Listado de Planetas'.toUpperCase(),
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomSearchBar(onSearch: onSearch),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
