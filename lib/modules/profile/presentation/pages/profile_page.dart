import 'package:challenge_petize/core/domain/widgets/web_view.dart';
import 'package:challenge_petize/modules/home/presentation/cubit/home_cubit.dart';
import 'package:challenge_petize/modules/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({
    super.key,
    required this.username,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                Modular.get<HomeCubit>()..getUser(username: widget.username),
          ),
          BlocProvider(
            create: (_) => Modular.get<ProfileCubit>()
              ..getUserRepo(username: widget.username),
          ),
        ],
        child: const ProfilePageContent(),
      ),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeSuccess) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                height: MediaQuery.of(context).size.height * 0.3,
                color: const Color(0x99eaddff),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        state.data.name,
                        style: GoogleFonts.inter(fontSize: 20),
                      ),
                      subtitle: Text(
                        '@${state.data.login}',
                        style: GoogleFonts.inter(fontSize: 16),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        foregroundImage: NetworkImage(state.data.avatarUrl),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset('assets/vectors/peoples.svg'),
                        Text(
                          '${state.data.followers} seguidores',
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SvgPicture.asset('assets/vectors/heart.svg'),
                        Text(
                          '${state.data.following} seguindo',
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      state.data.bio.toString(),
                      style: GoogleFonts.inter(fontSize: 18),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Wrap(
                      spacing: MediaQuery.of(context).size.width * 0.02,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runSpacing: MediaQuery.of(context).size.height * 0.02,
                      children: [
                        if (state.data.company!.isNotEmpty)
                          SvgPicture.asset('assets/vectors/company.svg'),
                        Text(
                          state.data.company.toString(),
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                        if (state.data.location!.isNotEmpty)
                          SvgPicture.asset('assets/vectors/location.svg'),
                        Text(
                          state.data.location.toString(),
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                        if (state.data.email!.isNotEmpty)
                          SvgPicture.asset('assets/vectors/email.svg'),
                        Text(
                          state.data.email.toString(),
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                        if (state.data.blog!.isNotEmpty)
                          SvgPicture.asset('assets/vectors/blog.svg'),
                        InkWell(
                          onTap: () {
                            final url = state.data.blog!;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewPage(url: url),
                              ),
                            );
                          },
                          child: Text(
                            state.data.blog.toString(),
                            style: GoogleFonts.inter(fontSize: 16),
                          ),
                        ),
                        if (state.data.twitterUsername!.isNotEmpty)
                          SvgPicture.asset('assets/vectors/twitter.svg'),
                        if (state.data.twitterUsername!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              final twitterUsername =
                                  state.data.twitterUsername;
                              final url = 'https://x.com/$twitterUsername';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewPage(url: url),
                                ),
                              );
                            },
                            child: Text(
                              '@${state.data.twitterUsername.toString()}',
                              style: GoogleFonts.inter(fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: Text(
                'Não há usuários com esse nome',
                style: GoogleFonts.nunito(),
              ),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, repoState) {
              if (repoState is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(repoState.message.toString())),
                );
              }
            },
            builder: (context, repoState) {
              if (repoState is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (repoState is ProfileSuccess) {
                return repoState.data.isEmpty
                    ? const Text('Nenhum repositório encontrado')
                    : ListView.builder(
                        itemCount: repoState.data.length,
                        itemBuilder: (_, index) {
                          final repo = repoState.data[index];
                          DateTime updatedAt = DateTime.parse(repo.updatedAt);
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    final repoName = repo.htmlUrl;
                                    final url = repoName;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WebViewPage(url: url),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    repo.name,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.016),
                                Text(
                                  repo.description,
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.016),
                                Row(
                                  children: [
                                    const Icon(Icons.star_border),
                                    Text(
                                      repo.stargazersCount.toString(),
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.016),
                                    Text(
                                      '•',
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.016),
                                    Text(
                                      'Atualizado há ${_getDaysAgo(updatedAt)} dias',
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        });
              }
              return const SizedBox.shrink();
            },
          ),
        )
      ],
    );
  }

  int _getDaysAgo(DateTime updatedAt) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(updatedAt).inDays;
    return difference;
  }
}
