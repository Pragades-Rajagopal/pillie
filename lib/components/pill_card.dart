import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillie_app/app/user_inventory/services/pill_database.dart';
import 'package:pillie_app/models/pill_model.dart';

class PillCard extends StatelessWidget {
  final PillModel pill;
  const PillCard({
    super.key,
    required this.pill,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(pill.id!),
      direction: DismissDirection.startToEnd,
      background: Container(
        margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.archivebox,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Archive',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onDismissed: (_) => PillDatabase(pill.userId!).archivePill(pill.id!),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
        margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pill.brand}',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${pill.name}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Column(
                children: [
                  timeIndicator(context, 'Day', pill.day!),
                  const SizedBox(height: 4),
                  timeIndicator(context, 'Noon', pill.noon!),
                  const SizedBox(height: 4),
                  timeIndicator(context, 'Night', pill.night!),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 12.0),
                      child: Text(
                        '${pill.count}',
                        style: const TextStyle(fontSize: 28.0),
                      ),
                    ),
                  ),
                  const Text(
                    'left',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container timeIndicator(BuildContext context, String text, bool value) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor(context, value),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: weight(value),
          ),
        ),
      ),
    );
  }

  Color bgColor(BuildContext context, bool value) => value == true
      ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
      : Theme.of(context).colorScheme.tertiary.withOpacity(0.1);

  FontWeight? weight(bool value) => value == true ? FontWeight.bold : null;
}
