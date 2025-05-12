import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillie_app/app/auth/services/auth_service.dart';
import 'package:pillie_app/app/profile/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = authService.getCurrentUser();
    final userName = user!.toString().split('@')[0].toUpperCase();

    const users = [
      {
        "name": "You",
        "img":
            "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "daysToRefill": "21",
        "actionNeeded": "2"
      },
      {
        "name": "Alex",
        "img":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "daysToRefill": "8",
        "actionNeeded": "1"
      },
      {
        "name": "Marc",
        "img":
            "https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "daysToRefill": "10",
        "actionNeeded": "8"
      },
      {
        "name": "Anna",
        "img":
            "https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?q=80&w=2417&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "daysToRefill": "2",
        "actionNeeded": "10"
      },
    ];

    final addUserCardPos = users.length;

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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == addUserCardPos) {
                  return Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surface,
                    // color: Colors.lightGreen[50],
                    margin: const EdgeInsets.fromLTRB(18, 14, 18, 30),
                    // shape: RoundedRectangleBorder(
                    //   side: const BorderSide(
                    //     color: Color.fromRGBO(220, 237, 200, 1),
                    //     width: 0.2,
                    //   ),
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Theme.of(context).colorScheme.surface,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.add_circled,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Add new user',
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodySmall?.fontSize,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                final dataIndex = index > addUserCardPos ? index - 1 : index;
                return Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surface,
                  // color: Colors.lightGreen[50],
                  margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromRGBO(220, 237, 200, 1),
                      width: 0.5,
                    ),
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
                              backgroundImage:
                                  NetworkImage('${users[dataIndex]['img']}'),
                              radius: 32,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${users[dataIndex]['name']}',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontSize,
                                color: Theme.of(context).colorScheme.primary,
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
                              '${users[dataIndex]['daysToRefill']} days left for refill',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.fontSize,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${users[index]['actionNeeded']} tables require immediate action',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.fontSize,
                                color: Theme.of(context).colorScheme.primary,
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
              childCount: users.length + 1,
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       if (index == addUserCardPos) {
          //         return const Card(
          //           color: Colors.amber,
          //           child: ListTile(title: Text('Extra Card')),
          //         );
          //       }
          //       final dataIndex = index > addUserCardPos ? index - 1 : index;
          //       return Card(
          //         child: ListTile(title: Text('Item #${[dataIndex]}')),
          //       );
          //     },
          //     childCount: users.length + 1,
          //   ),
          // )
        ],
      ),
    );
  }
}
