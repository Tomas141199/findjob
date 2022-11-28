import 'package:findjob_app/services/jobs_service.dart';
import 'package:flutter/material.dart';
import 'package:findjob_app/models/models.dart';
import 'package:provider/provider.dart';

class JobSlider extends StatelessWidget {
  final List<Job> jobs;
  final String? title;

  JobSlider({
    Key? key,
    required this.jobs,
    this.title,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: jobs.length,
                itemBuilder: (_, int index) => _MoviePoster(jobs[index])),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Job job;

  const _MoviePoster(this.job);

  @override
  Widget build(BuildContext context) {
    final jobService = Provider.of<JobsService>(context);

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              jobService.selectedJob = job;
              Navigator.pushNamed(context, 'verOferta',
                  arguments: WidgetArguments(edit: false, action: 1));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.png'),
                image: NetworkImage(job.picture ??
                    "https://www.fcmlindia.com/images/fifty-days-campaign/no-image.jpg"),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            job.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
