import 'package:findjob_app/models/models.dart';
import 'package:findjob_app/services/services.dart';
import 'package:findjob_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final userService = Provider.of<UserDataService>(context);
    final user = userService.selectedUser;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(user),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(user),
          _Overview(user.description!),
          _Overview(user.description!),
          _Overview(user.description!),
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final UserData user;

  const _CustomAppBar(this.user);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            user.displayName,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/giphy.gif'),
          image: NetworkImage(user.photoUrl!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final UserData user;

  const _PosterAndTitle(this.user);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: user.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.png'),
                image: NetworkImage(user.photoUrl!),
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.displayName,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              Text(user.contactEmail,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              Row(
                children: [
                  const Icon(Icons.call, size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    '${user.tel}',
                    style: textTheme.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String description;

  const _Overview(this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
