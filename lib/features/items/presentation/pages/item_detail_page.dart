import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../domain/entities/character_entity.dart';

class ItemDetailPage extends StatelessWidget {
  final CharacterEntity character;

  const ItemDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'character_${character.id}',
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  fit: BoxFit.cover,
                  placeholder: (ctx, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (ctx, url, err) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            actions: [
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  final isFavorite = state is FavoritesLoaded &&
                      state.favorites.any((f) => f.id == character.id);
                  return IconButton(
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    color: isFavorite ? Colors.red : Colors.white,
                    onPressed: () {
                      context.read<FavoritesBloc>().add(
                            ToggleFavorite(FavoriteEntity(
                              id: character.id,
                              name: character.name,
                              image: character.image,
                              status: character.status,
                              species: character.species,
                            )),
                          );
                    },
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _InfoSection(title: 'Status', value: character.status),
                  _InfoSection(title: 'Species', value: character.species),
                  _InfoSection(title: 'Gender', value: character.gender),
                  _InfoSection(title: 'Origin', value: character.origin),
                  _InfoSection(title: 'Last known location', value: character.location),
                  const SizedBox(height: 16),
                  Text(
                    'Episodes (${character.episode.length})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Appeared in ${character.episode.length} episode${character.episode.length == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String value;

  const _InfoSection({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
