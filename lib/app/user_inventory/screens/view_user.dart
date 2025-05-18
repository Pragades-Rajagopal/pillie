import 'package:flutter/material.dart';
import 'package:pillie_app/models/user_model.dart';

class ViewUser extends StatefulWidget {
  final UserModel userInfo;
  const ViewUser({
    super.key,
    required this.userInfo,
  });

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    final user = widget.userInfo;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              // titlePadding: const EdgeInsets.symmetric(horizontal: 24.0),
              centerTitle: true,
              title: Text(
                "${user.name}",
                style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
              ),
              background: Padding(
                padding: const EdgeInsets.all(60.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${user.img}'),
                  radius: 80.0,
                ),
              ),
              collapseMode: CollapseMode.pin,
              stretchModes: const [StretchMode.blurBackground],
            ),
            expandedHeight: 260.0,
            backgroundColor: Colors.lightGreen[200],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 14.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dataElement('Blood Group', user.bloodGroup),
                  dataElement(
                      'DOB', user.dob != null ? user.dob.toString() : ''),
                  dataElement('Height',
                      user.height != null ? user.height.toString() : ''),
                  dataElement('Weight',
                      user.weight != null ? user.weight.toString() : ''),
                  dataElement('Medications', user.medications),
                  dataElement('Medical Notes', user.medicalNotes),
                  dataElement('Organ Donor', user.organDonor),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dataElement(String header, String? value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            value == null || value.isEmpty ? '-' : value,
            style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
        ],
      );
}
