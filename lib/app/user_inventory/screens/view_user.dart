import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillie_app/app/user_inventory/screens/edit_user.dart';
import 'package:pillie_app/app/user_inventory/services/pill_database.dart';
import 'package:pillie_app/app/user_inventory/widgets/pill_stream_builder.dart';
import 'package:pillie_app/components/common_components.dart';
import 'package:pillie_app/models/pill_model.dart';
import 'package:pillie_app/models/user_model.dart';
import 'package:pillie_app/utils/helper_functions.dart';

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
                    // color: Colors.black,
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
              // backgroundColor: Colors.lightGreen[200],
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUser(userInfo: user),
                    ),
                  ),
                  icon: const Icon(
                    CupertinoIcons.pencil_circle,
                    // color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => showAddPillBottomSheet(context),
                  icon: const Icon(
                    CupertinoIcons.add_circled,
                    // color: Colors.black,
                  ),
                )
              ],
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
              PillStreamBuilder(userId: widget.userInfo.id!),
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
                          'DOB',
                          user.dob != null
                              ? convertDateFormat(user.dob.toString(),
                                  format: 'dmy', separator: '-')
                              : ''),
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

  void showAddPillBottomSheet(BuildContext context) {
    final drugNameController = TextEditingController();
    final brandNameController = TextEditingController();
    final countController = TextEditingController();
    final dosageController = TextEditingController();
    final List<String> options = ['Day', 'Noon', 'Night'];
    final Set<int> selectedOptions = {};

    void addPill() async {
      await PillDatabase(widget.userInfo.id!).addPill(PillModel(
        name: drugNameController.text,
        brand: brandNameController.text,
        count: int.tryParse(countController.text),
        day: selectedOptions.contains(0) ? true : false,
        noon: selectedOptions.contains(1) ? true : false,
        night: selectedOptions.contains(2) ? true : false,
        dosage: int.tryParse(dosageController.text),
      ));
      if (context.mounted) Navigator.pop(context);
    }

    CommonComponents().pillBottomSheetModal(
      context,
      addPill,
      drugNameController,
      brandNameController,
      countController,
      dosageController,
      options,
      selectedOptions,
      "Add Pill",
    );
  }
}
