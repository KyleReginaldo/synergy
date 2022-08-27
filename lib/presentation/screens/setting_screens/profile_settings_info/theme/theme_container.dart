import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synergy/presentation/screens/setting_screens/profile_settings_info/theme/theme_provider.dart';

class ThemeController extends StatelessWidget {
  const ThemeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/light.png'
                  : 'assets/dark.png',
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 80,
            child: Align(
              alignment: Alignment.topCenter,
              child:
                  Consumer<ThemeProvider>(builder: (context, provider, child) {
                return DropdownButton<String>(
                  value: provider.currentTheme,
                  items: [
                    //Light, dark, and system
                    DropdownMenuItem<String>(
                      value: 'light',
                      child: Text(
                        'Light',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),

                    DropdownMenuItem<String>(
                      value: 'dark',
                      child: Text(
                        'Dark',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'system',
                      child: Text(
                        'System',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                  onChanged: (String? value) {
                    provider.changeTheme(value ?? 'system');
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
