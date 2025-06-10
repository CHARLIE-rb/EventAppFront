import 'package:events_app/core/inyeccion_dependencias/di.dart';
import 'package:events_app/features/profile/presentation/providers/profile_provider.dart';
import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/presentation/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:events_app/features/profile/presentation/widgets/logout_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<ProfileProvider>()),
      ],
      child: _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends StatefulWidget {
  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<_ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actualUser = context.read<SessionProvider>().currentUser;

    const double averageScore = 4.3; // TODO: Replace with real data
    const String profileImage = 'assets/images/defaultPerfilImage.jpg';

    return FutureBuilder<User?>(
      future: actualUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data!;
        final profileOptions = context
            .read<ProfileProvider>()
            .getProfileScreenItems(user.role);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ProfileHeader(
                  user: user,
                  averageScore: averageScore,
                  profileImage: profileImage,
                ),
              ),

              ...profileOptions.map((option) {
                return _sectionTile(
                  context,
                  icon: option.icon,
                  label: option.label,
                  builder: option.screen,
                );
              }),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LogoutButton(),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        );
      },
    );
  }

  SliverToBoxAdapter _sectionTile(
    BuildContext ctx, {
    required IconData icon,
    required String label,
    required WidgetBuilder builder,
  }) {
    final theme = Theme.of(ctx);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        // child: ListTile(
        //   contentPadding: const EdgeInsets.symmetric(
        //     horizontal: 12,
        //     vertical: 4,
        //   ),
        //   leading: Icon(icon, color: theme.colorScheme.onSurface),
        //   title: Text(
        //     label,
        //     style: TextStyle(
        //       fontSize: 18,
        //       color: theme.colorScheme.onSurfaceVariant,
        //     ),
        //   ),
        //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        //   onTap: () => Navigator.of(ctx).push(
        // MaterialPageRoute(builder: builder),
        // ),
        // ),
        child: Column(
          children: [
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                leading: Icon(icon, color: theme.colorScheme.onSurface),
                title: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap:
                    () => Navigator.of(
                      ctx,
                    ).push(MaterialPageRoute(builder: builder)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// Cabecera de perfil – imagen rectangular
// ==============================================================================
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.user,
    required this.averageScore,
    required this.profileImage,
  });

  final User user;
  final double averageScore;
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12 + topPadding, 16, 8),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileImageRectangular(imagePath: profileImage),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name} ${user.lastName}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.role.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 24),
                        const SizedBox(width: 6),
                        Text(
                          averageScore.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Widget de imagen con marco rectangular
// -----------------------------------------------------------------------------
class _ProfileImageRectangular extends StatelessWidget {
  const _ProfileImageRectangular({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
