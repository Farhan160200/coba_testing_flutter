import 'package:coba_testing_flutter/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AkunFragment extends StatefulWidget {
  @override
  _AkunFragmentState createState() => _AkunFragmentState();
}

class _AkunFragmentState extends State<AkunFragment> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isLoggedIn()) {
      return _buildUserDataView(userProvider);
    } else {
      return _buildLoginView(userProvider);
    }
  }

  Widget _buildUserDataView(UserProvider userProvider) {
    final userData = userProvider.userData;
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan gambar pengguna dengan ukuran 300x300 piksel dan sudut bulat 20
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://sobatps.devel-filkomub.site/img/${userData!.image}',
                width: 300,
                height: 300,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error); // Tampilkan ikon error jika gagal memuat gambar
                },
              ),
            ),
            SizedBox(height: 16), // Berikan sedikit ruang antara gambar dan teks
            Text('Name: ${userData.name}'),
            Text('Email: ${userData.email}'),
            Text('Username: ${userData.username}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                userProvider.logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginView(UserProvider userProvider) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                userProvider.login(email, password);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
