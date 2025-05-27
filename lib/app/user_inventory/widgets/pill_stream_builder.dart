import 'package:flutter/material.dart';
import 'package:pillie_app/app/user_inventory/services/pill_database.dart';
import 'package:pillie_app/components/pill_card.dart';

class PillStreamBuilder extends StatelessWidget {
  final String userId;
  const PillStreamBuilder({
    super.key,
    required this.userId,
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
        final pills = snapshot.data!;
        if (pills.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
            child: Text(
              'Add pills by clicking on the below icon',
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
              child: PillCard(pill: pills[index]),
            );
          },
        );
      },
    );
  }
}
