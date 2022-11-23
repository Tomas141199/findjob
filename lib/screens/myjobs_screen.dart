import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({Key? key}) : super(key: key);

  @override
  _MyJobsScreen createState() => _MyJobsScreen();
}

class _MyJobsScreen extends State<MyJobsScreen> {
  @override
  Widget build(BuildContext context) {
    final jobService = Provider.of<JobsService>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _listaItemMisOfertas(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          jobService.selectedJob = Job(
            address: '',
            author: '',
            city: '',
            description: '',
            establishment: '',
            publishedAt: '',
            salary: 0,
            authorId: '',
            title: '',
            town: '',
          );
          print(jobService.isLoading);
          Navigator.pushNamed(context, 'agregarOferta');
        },
        elevation: 4,
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listaItemMisOfertas() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(3, (int index) {
          return WidgetOfertaDos();
        }),
      ),
    );
  }
}
