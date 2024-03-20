import 'package:coba_testing_flutter/akun_fragment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba_testing_flutter/akun_view_model.dart';
import 'package:coba_testing_flutter/api_service.dart';
import 'package:coba_testing_flutter/repository.dart'; // Sesuaikan dengan struktur paket Anda

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService(),
        ),
        ProxyProvider<ApiService, Repository>(
          update: (_, apiService, __) => Repository(apiService),
        ),
        ChangeNotifierProvider<AkunViewModel>(
          create: (context) {
            final repository = Provider.of<Repository>(context, listen: false);
            final token =
                "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3NvYmF0cHMuZGV2ZWwtZmlsa29tdWIuc2l0ZS9hcGkvbG9naW4iLCJpYXQiOjE3MTA4NjMwOTUsImV4cCI6MTcxMTQ2Nzg5NSwibmJmIjoxNzEwODYzMDk1LCJqdGkiOiJHMFBPU1FvUzA5Wlp3MFlFIiwic3ViIjoiMzAiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.2ISbhEQobcsuhy0bibolvhpcaAQ5auwJl9u-FTywzr0";
            return AkunViewModel(repository, token);
          },
        ),
      ],
      child: MaterialApp(
        title: 'MyApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AkunFragment(), // Ganti dengan halaman yang benar
      ),
    );
  }
}