import 'package:coba_testing_flutter/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'movie_page.dart'; // Import MoviePage

class AkunFragment extends StatefulWidget {
  @override
  _AkunFragmentState createState() => _AkunFragmentState();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  return Icon(Icons
                      .error); // Tampilkan ikon error jika gagal memuat gambar
                },
              ),
            ),
            SizedBox(height: 16),
            // Berikan sedikit ruang antara gambar dan teks
            Text('Name: ${userData.name}'),
            Text('Email: ${userData.email}'),
            Text('Username: ${userData.username}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      MoviePage()), // Pindah ke halaman MoviePage saat tombol ditekan
                );
              },
              child: Text(
                  'Lihat Film'), // Ubah teks tombol menjadi 'Lihat Film'
            ),
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
        title: Text('Login',
            style: TextStyle(color: Colors.black, fontSize: 50, fontStyle: FontStyle.italic)
        ),

      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                userProvider.login(email, password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Buat Coba-Coba Ajah',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}