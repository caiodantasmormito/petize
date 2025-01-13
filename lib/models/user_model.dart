/*class UserModel {
  final String username;
  final int id;
  final String nodeId;
  final String avatarUrl;

  final String followersUrl;
  final String followingUrl;

  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;

  final bool siteAdmin;
  final String name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;

  final String? bio;
  final String? twitterUsername;

  final int followers;
  final int following;

  UserModel({
    required this.username,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.siteAdmin,
    required this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.twitterUsername,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      followersUrl: json['followers_url'],
      followingUrl: json['following_url'],
      starredUrl: json['starred_url'],
      subscriptionsUrl: json['subscriptions_url'],
      organizationsUrl: json['organizations_url'],
      reposUrl: json['repos_url'],
      siteAdmin: json['site_admin'],
      name: json['name'],
      company: json['company'],
      blog: json['blog'],
      location: json['location'],
      email: json['email'],
      bio: json['bio'],
      twitterUsername: json['twitter_username'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}
*/