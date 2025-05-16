import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillie_app/app/auth/services/auth_service.dart';
import 'package:pillie_app/app/home/services/home_database.dart';
import 'package:pillie_app/app/profile/screens/profile_page.dart';
import 'package:pillie_app/app/user_inventory/screens/add_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  final db = HomeDatabase();

  @override
  Widget build(BuildContext context) {
    final user = authService.getCurrentUser();
    final userName = user!.toString().split('@')[0].toUpperCase();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.all(18),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Pillie",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                          ),
                        ),
                        Text(
                          'Welcome $userName',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1496672254107-b07a26403885?q=80&w=3088&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      ),
                    ),
                  ),
                ],
              ),
              // background: Image.network(
              //   "https://images.unsplash.com/photo-1628771065518-0d82f1938462?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              //   fit: BoxFit.fitWidth,
              // ),
              background: Container(
                color: Colors.lightGreen[200],
              ),
              stretchModes: const [StretchMode.fadeTitle],
            ),
            expandedHeight: 120,
          ),
          StreamBuilder(
            stream: db.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('Something went wrong'),
                  ),
                );
              }
              final users = snapshot.data!;
              if (users.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('No users'),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final user = users[index];
                    return Card(
                      elevation: 0,
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.2),
                      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                      shape: RoundedRectangleBorder(
                        // side: const BorderSide(
                        //   color: Color.fromRGBO(220, 237, 200, 1),
                        //   width: 0.5,
                        // ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Theme.of(context).colorScheme.surface,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('${user.img}'),
                                  radius: 32,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${user.name}',
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
                              ],
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user.daysToRefill} days left for refill',
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.fontSize,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${user.itemsAttention} tables require immediate action',
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.fontSize,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: users.length,
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 28.0),
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddUser(),
                  ),
                ),
                icon: Icon(
                  CupertinoIcons.add_circled,
                  size: 28.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
