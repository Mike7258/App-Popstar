import 'package:flutter/material.dart';
import 'package:popstar_database/screens/movies_screen.dart'; // Importar la pantalla de películas
import 'package:popstar_database/screens/search_screen.dart'; // Importar la pantalla de búsqueda
import 'package:popstar_database/themes/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice de la pestaña actualmente seleccionada
  int _selectedIndex = 0;

  // Lista de widgets (contenidos) que se mostrarán en el cuerpo (body) del Scaffold
  // ¡Estos widgets ya NO contienen un Scaffold interno!
  static const List<Widget> _widgetContents = <Widget>[
    _HomeContent(), // 0: Contenido del Home
    MoviesScreen(), // 1: Contenido de todas las películas
    SearchScreen(), // 2: Contenido de búsqueda
  ];
  
  // Títulos para el AppBar
  static const List<String> _pageTitles = <String>[
    'Inicio Popstar',
    'Todas las Películas',
    'Buscar Películas',
  ];

  // Función que se llama cuando se toca un ítem del BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar único que cambia de título según la pestaña seleccionada
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
      ),
      
      // Muestra el widget correspondiente al índice seleccionado (SOLO EL CUERPO/CONTENIDO)
      body: Center(
        child: _widgetContents.elementAt(_selectedIndex),
      ),
      
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Películas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.accentColor, // Color Naranja
        unselectedItemColor: AppTheme.lightPurple, // Lila claro
        backgroundColor: AppTheme.primaryColor, // Fondo Morado
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Mantiene el color de fondo en todos los ítems
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget interno para el contenido de la pestaña "Inicio"
// IMPORTANTE: Ya no retorna un Scaffold, solo el contenido del cuerpo (body).
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    // Retornamos directamente el contenido de la pantalla, sin Scaffold ni AppBar.
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_rate_rounded,
            size: 80,
            color: AppTheme.accentColor.withOpacity(0.7),
          ),
          const SizedBox(height: 20),
          Text(
            '¡Bienvenido a Popstar!',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Usa la barra de navegación inferior para ver todas las películas o buscar un título específico.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}