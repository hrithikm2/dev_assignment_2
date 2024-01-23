part of '../add_employee_page.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({required this.cubit, super.key});
  final AddEmployeeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shrinkWrap: true,
      itemCount: cubit.roles.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          cubit.roleController.text = cubit.roles[index];
          context.pop;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(cubit.roles[index]),
        ),
      ),
    );
  }
}
