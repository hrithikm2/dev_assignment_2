import 'package:dev_assignment_2/add_employee/cubit/add_employee_cubit.dart';
import 'package:dev_assignment_2/employee_list/employee_list.dart';
import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddEmployeeCubit(),
          ),
          BlocProvider(
            create: (context) => EmployeeListCubit(),
          ),
        ],
        child: MaterialApp(
          color: AppColors.mainColor,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            dialogBackgroundColor: AppColors.white,
            fontFamily: GoogleFonts.roboto().fontFamily,
            primaryColor: AppColors.mainColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.mainColor,
              titleTextStyle: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
            useMaterial3: true,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.mainColor,
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const EmployeeListPage(),
        ),
      ),
    );
  }
}
