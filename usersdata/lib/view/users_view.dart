import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usersdata/controller/user_provider.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});
  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fecthusers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: Text('provider.error!'));
          }
          if (provider.error != null) {
            return Center(child: Text('provider.error!'));
          }
          return ListView.builder(
            itemCount: provider.user.length,
            itemBuilder: (context, index) {
              final user = provider.user[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                ),
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}
