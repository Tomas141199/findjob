import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({Key? key}) : super(key: key);

  @override
  _MyJobsScreen createState() => _MyJobsScreen();
}

class _MyJobsScreen extends State<MyJobsScreen> {
  @override
  Widget build(BuildContext context) {

    final jobsService = Provider.of<JobsService>(context);
    final jobsList = jobsService.myJobs;
    if (jobsService.isLoading) return const LoadingScreen();

    return Scaffold(
     body: ListView.builder(
        itemCount: jobsList.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            jobsService.selectedJob = jobsList[index].copy();
            Navigator.pushNamed(context, 'agregarOferta',arguments: WidgetArguments(edit: true,action: 1));
          },
          child: JobCard(job: jobsList[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          jobsService.selectedJob = Job(
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
          print(jobsService.isLoading);
          Navigator.pushNamed(context, 'agregarOferta',arguments: WidgetArguments(edit: true, action:2));
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
