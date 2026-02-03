import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:token/controller/auth_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      // ignore: use_build_context_synchronously
      context.read<AuthController>().loadProfile();
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:const Text('profile')),
      body: Consumer<AuthController>(builder:(context,controller,_){
        if(controller.isProfileLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(controller.profile == null){
          return Center(
            child: Text(
              controller.error.isNotEmpty
              ?controller.error
              :'No Profile Data',
            ),
          );
        }
        return Padding(padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name : ${controller.profile ! ['name']}',
            style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10,),
            Text(
              'Email : ${controller.profile!['email']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10,),
            Text('Role :${controller.profile!['role']}',),

          ],
        ),
        );
      }
      )
    );
  }
}
