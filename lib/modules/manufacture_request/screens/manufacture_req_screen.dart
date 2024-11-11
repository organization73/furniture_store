import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/modules/manufacture_request/screens/add_new_request/screens/add_new_request.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ManufactureRequestsPage extends StatelessWidget {
  const ManufactureRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a request',
        onPressed: () => Get.to(
          () => const AddManRequestPage(),
        ),
        heroTag: 'addFAB',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Manufacture Requests'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView.separated(
            itemCount: _feedItems.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              final item = _feedItems[index];
              return Padding(
                padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AvatarImage(item.user.avatar),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: item.user.firstName,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ]),
                              )),
                              Text('· 5m',
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                          if (item.content != null)
                            Text(
                              item.content!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          if (item.imageUrl != null)
                            CachedNetworkImage(
                              imageUrl: item.imageUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 200,
                                margin: const EdgeInsets.only(top: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error_rounded,
                                size: TSizes.iconLg,
                              ),
                            ),
                          _ActionsRow(item: item)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  final String url;
  const _AvatarImage(this.url);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(
          Icons.person_2_rounded,
          size: TSizes.iconLg,
        ),
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  final FeedItem item;
  const _ActionsRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.grey, size: 18),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.grey),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.mode_comment_outlined),
            label: const Text('ChatMessageModel'),
          ),
        ],
      ),
    );
  }
}

class FeedItem {
  final String? content;
  final String? imageUrl;
  final UserModel user;
  final int commentsCount;
  final int likesCount;
  final int retweetsCount;

  FeedItem(
      {this.content,
      this.imageUrl,
      required this.user,
      this.commentsCount = 0,
      this.likesCount = 0,
      this.retweetsCount = 0});
}

final List<UserModel> _users = [
  UserModel(
    avatar: 'https://picsum.photos/id/1062/80/80',
    firstName: 'John Doe',
    email: 'test@gmail.com',
  ),
  UserModel(
    avatar: 'https://picsum.photos/id/1066/80/80',
    firstName: 'John Doe',
    email: 'test@gmail.com',
  ),
  UserModel(
    avatar: 'https://picsum.photos/id/1072/80/80',
    firstName: 'John Doe',
    email: 'test@gmail.com',
  ),
  UserModel(
    avatar: 'https://picsum.photos/id/80/80/80',
    firstName: 'John Doe',
    email: 'test@gmail.com',
  ),
];

final List<FeedItem> _feedItems = [
  FeedItem(
    content:
        "A son asked his father (a programmer) why the sun rises in the east, and sets in the west. His response? It works, don’t touch!",
    user: _users[0],
    imageUrl: "https://picsum.photos/id/1000/960/540",
    likesCount: 100,
    commentsCount: 10,
    retweetsCount: 1,
  ),
  FeedItem(
      user: _users[1],
      imageUrl: "https://picsum.photos/id/1001/960/540",
      likesCount: 10,
      commentsCount: 2),
  FeedItem(
      user: _users[0],
      content:
          "How many programmers does it take to change a light bulb? None, that’s a hardware problem.",
      likesCount: 50,
      commentsCount: 22,
      retweetsCount: 30),
  FeedItem(
      user: _users[1],
      content:
          "Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the Universe trying to produce bigger and better idiots. So far, the Universe is winning.",
      imageUrl: "https://picsum.photos/id/1002/960/540",
      likesCount: 500,
      commentsCount: 202,
      retweetsCount: 120),
  FeedItem(
    user: _users[2],
    content: "Good morning!",
    imageUrl: "https://picsum.photos/id/1003/960/540",
  ),
  FeedItem(
    user: _users[1],
    imageUrl: "https://picsum.photos/id/1004/960/540",
  ),
  FeedItem(
    user: _users[3],
    imageUrl: "https://picsum.photos/id/1005/960/540",
  ),
  FeedItem(
    user: _users[0],
    imageUrl: "https://picsum.photos/id/1006/960/540",
  ),
];
