import 'package:flutter/material.dart';
import 'package:findjob_app/theme/app_theme.dart';

import '../models/models.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTopBar(
            establishment: job.establishment,
            published: job.publishedAt,
            author: job.author,
          ),
          _CardTitle(
            title: job.title,
          ),
          _CardDescription(description: job.description),
          _CardPoster(
            photoUrl: job.picture,
          ),
          const SizedBox(height: 10),
          const Divider(),
          _CardActionsAndDetails(
            city: job.city,
            salary: job.salary.toString(),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _CardActionsAndDetails extends StatelessWidget {
  final String city;
  final String salary;
  const _CardActionsAndDetails({
    Key? key,
    required this.city,
    required this.salary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: AppTheme.deepBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(city,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(width: 10),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.monetization_on,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(salary,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardPoster extends StatelessWidget {
  final String? photoUrl;
  const _CardPoster({
    Key? key,
    this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: (photoUrl != null)
            ? FadeInImage(
                placeholder: const AssetImage("assets/giphy.gif"),
                image: NetworkImage(photoUrl!))
            : const Image(
                image: AssetImage("assets/no-image.png"),
              ));
  }
}

class _CardDescription extends StatelessWidget {
  final String description;
  const _CardDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      margin: const EdgeInsets.only(top: 6, bottom: 20),
      child: Text(
        description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final String title;
  const _CardTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final String establishment;
  final String published;
  final String author;

  const _CardTopBar({
    Key? key,
    required this.establishment,
    required this.published,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.getRandomColor(),
            child: Text(
              establishment[0],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                establishment,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Text(
                "$published - $author",
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
