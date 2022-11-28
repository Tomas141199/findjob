import 'package:findjob_app/providers/job_provider.dart';
import 'package:findjob_app/services/jobs_service.dart';
import 'package:flutter/material.dart';
import 'package:findjob_app/models/models.dart';
import 'package:provider/provider.dart';

class JobSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar trabajo';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _emptyContainer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.error_outline,
            color: Colors.black38,
            size: 130,
          ),
          Text(
            "Sin resultados",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
    jobsProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: jobsProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Job>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final jobs = snapshot.data!;

        if (jobs.isEmpty) return _emptyContainer();

        return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (_, int index) => _JobItem(jobs[index]));
      },
    );
  }
}

class _JobItem extends StatelessWidget {
  final Job job;

  const _JobItem(this.job);

  @override
  Widget build(BuildContext context) {
    final jobService = Provider.of<JobsService>(context);
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.png'),
        image: NetworkImage(job.picture ??
            "https://www.fcmlindia.com/images/fifty-days-campaign/no-image.jpg"),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(job.title),
      subtitle: Text(job.city),
      onTap: () {
        jobService.selectedJob = job;
        Navigator.pushNamed(context, 'verOferta',
            arguments: WidgetArguments(edit: false, action: 1));
      },
    );
  }
}
