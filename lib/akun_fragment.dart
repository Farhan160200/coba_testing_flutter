import 'package:coba_testing_flutter/akun_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AkunFragment extends StatefulWidget {
  @override
  _AkunFragmentState createState() => _AkunFragmentState();
}

class _AkunFragmentState extends State<AkunFragment> {
  late AkunViewModel _akunViewModel;

  @override
  void initState() {
    super.initState();
    _akunViewModel = context.read<AkunViewModel>();
    _akunViewModel.fetchData(_akunViewModel.token); // Memanggil fetchData dengan token yang telah disimpan di AkunViewModel
    print('Fetching user data...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
      ),
      body: Center(
        child: Consumer<AkunViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return CircularProgressIndicator();
            } else {
              final userData = viewModel.userData;
              return userData != null ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email: ${userData.email}'),
                  Text('Name: ${userData.name}'),
                  Text('UserName: ${userData.username}')
                ],
              ) : Text('User data not available');
            }
          },
        ),
      ),
    );
  }
}
