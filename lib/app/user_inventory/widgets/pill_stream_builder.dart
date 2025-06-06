import 'package:flutter/material.dart';
import 'package:pillie_app/app/user_inventory/services/pill_database.dart';
import 'package:pillie_app/components/common_components.dart';
import 'package:pillie_app/components/pill_card.dart';
import 'package:pillie_app/models/pill_model.dart';

class PillStreamBuilder extends StatelessWidget {
  final String userId;
  final String type;
  const PillStreamBuilder({
    super.key,
    required this.userId,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final PillDatabase pillDatabase = PillDatabase(userId);
    return StreamBuilder(
      stream: pillDatabase.pillStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        final pills = snapshot.data!
            .where(
                (pill) => pill.isArchived == (type == 'archive' ? true : false))
            .toList();
        if (pills.isEmpty && type == 'active') {
          return Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
            child: Text(
              'Add pills by clicking on the add icon',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: pills.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: GestureDetector(
                onTap: () => showEditPillBottomSheet(context, pills[index]),
                child: PillCard(pill: pills[index], pillType: type),
              ),
            );
          },
        );
      },
    );
  }

  void showEditPillBottomSheet(BuildContext context, PillModel pill) {
    final drugNameController = TextEditingController(text: pill.name ?? '');
    final brandNameController = TextEditingController(text: pill.brand ?? '');
    final countController =
        TextEditingController(text: pill.count?.toString() ?? '');
    final dosageController =
        TextEditingController(text: pill.dosage?.toString() ?? '');
    final List<String> options = ['Day', 'Noon', 'Night'];
    final Set<int> selectedOptions = {
      if (pill.day == true) 0,
      if (pill.noon == true) 1,
      if (pill.night == true) 2,
    };

    void editPill() async {
      await PillDatabase(userId).editPill(
        PillModel(
          name: drugNameController.text,
          brand: brandNameController.text,
          count: int.tryParse(countController.text),
          day: selectedOptions.contains(0) ? true : false,
          noon: selectedOptions.contains(1) ? true : false,
          night: selectedOptions.contains(2) ? true : false,
          dosage: double.tryParse(dosageController.text),
        ),
        pill.id!,
      );
      if (context.mounted) Navigator.pop(context);
    }

    void deletePill() async {
      await PillDatabase(userId).deletePill(pill.id!);
      if (context.mounted) Navigator.pop(context);
    }

    CommonComponents().pillBottomSheetModal(
      context,
      editPill,
      drugNameController,
      brandNameController,
      countController,
      dosageController,
      options,
      selectedOptions,
      'Edit Pill',
      secondaryButtonText: 'Delete',
      secondaryOnTapAction: deletePill,
    );
  }
}
