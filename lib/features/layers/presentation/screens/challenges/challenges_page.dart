import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Text(
          'Challenges Page',
          style: TextStyle(fontSize: 24),
        ),
        _buildCustomNavbarWidget(),
          ],

        )
      ),
    );
  }

    _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 3,
    );
  }
}