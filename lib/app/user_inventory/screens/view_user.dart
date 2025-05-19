import 'package:flutter/material.dart';
import 'package:pillie_app/components/text_button.dart';
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
                        labelPadding: const EdgeInsets.fromLTRB(14, 0, 60, 0),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 14.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextButton(buttonText: 'Add a pill', onTap: () {}),
                      Card(
                        elevation: 0,
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.2),
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
                                    'Tygecol',
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.fontSize,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Tygecycline',
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.fontSize,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 4.0),
                                      child: Text(
                                        'Day',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 4.0),
                                      child: Text(
                                        'Noon',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 4.0),
                                      child: Text(
                                        'Night',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 12.0),
                                      child: Text(
                                        '9',
                                        style: TextStyle(fontSize: 28.0),
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
                      )
                    ],
                  ),
                ),
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
