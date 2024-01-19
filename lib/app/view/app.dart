import 'package:dev_assignment_2/employee_list/employee_list.dart';
import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        color: AppColors.appMainColor,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.roboto().fontFamily,
          primaryColor: AppColors.appMainColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.appMainColor,
            titleTextStyle: TextStyle(
              color: AppColors.appWhite,
              fontSize: 18,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          useMaterial3: true,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.appMainColor,
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const EmployeeListPage(),
      ),
    );
  }
}
