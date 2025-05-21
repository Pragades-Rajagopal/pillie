import 'package:flutter/material.dart';
import 'package:pillie_app/app/user_inventory/services/pill_database.dart';
import 'package:pillie_app/components/pill_card.dart';
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
    final PillDatabase pillDatabase = PillDatabase(user.id!);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
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
                  padding: const EdgeInsets.all(60),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('${user.img}'),
                    // radius: 10.0,
                  ),
                ),
                collapseMode: CollapseMode.pin,
                stretchModes: const [StretchMode.blurBackground],
              ),
              expandedHeight: 200.0,
              backgroundColor: Colors.lightGreen[200],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        isScrollable: true,
                        splashFactory: NoSplash.splashFactory,
                        tabAlignment: TabAlignment.start,
                        overlayColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        labelColor: Theme.of(context).colorScheme.primary,
                        labelStyle: const TextStyle(fontSize: 24),
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.tertiary,
                        indicatorColor: Colors.transparent,
                        indicatorWeight: 0.1,
                        labelPadding: const EdgeInsets.fromLTRB(14, 10, 60, 0),
                        dividerColor: Colors.transparent,
                        tabs: const [Text("Inventory"), Text("Info")],
                      )
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
          body: TabBarView(
            children: [
              StreamBuilder(
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 14.0,
                ),
                child: SingleChildScrollView(
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
              ),
            ],
          ),
        ),
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
