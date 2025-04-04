import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildCustomNavbarWidget(),
      body: Center(
        child: Column(
          children: [
            Text(
          'Map Page',
          style: TextStyle(fontSize: 24),
        ),
          ],

        )
      ),
    );
  }

    _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 4,
    );
  }
}