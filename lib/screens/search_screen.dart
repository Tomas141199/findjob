import 'package:flutter/material.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/screens/screens.dart';
import 'package:findjob_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:findjob_app/models/models.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final jobsService = Provider.of<JobsService>(context);
    final jobsList = jobsService.jobs;

    if (jobsService.isLoading) return const LoadingScreen();

    return jobsList.length>0?Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      body: ListView.builder(
        itemCount: jobsList.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            jobsService.selectedJob = jobsList[index].copy();
            Navigator.pushNamed(context, 'verOferta',
                arguments: WidgetArguments(edit: false, action: 1));
          },
          child: JobCard(job: jobsList[index]),
        ),
      ),
    ):_emptyContainer();
  }

  Widget _emptyContainer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 130,
          ),
          Text(
            "No se encontraron ofertas disponibles",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
   }
}
