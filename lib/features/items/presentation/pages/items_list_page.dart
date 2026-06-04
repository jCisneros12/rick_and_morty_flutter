import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../bloc/items_bloc.dart';
import '../widgets/character_card.dart';
import 'item_detail_page.dart';

class ItemsListPage extends StatefulWidget {
  const ItemsListPage({super.key});

  @override
  State<ItemsListPage> createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ItemsBloc>().add(LoadCharacters());
    context.read<FavoritesBloc>().add(LoadFavorites());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ItemsBloc>().add(LoadMoreCharacters());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ItemsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(state.message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<ItemsBloc>().add(RefreshCharacters()),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is ItemsEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 48),
                SizedBox(height: 16),
                Text('No characters found'),
              ],
            ),
          );
        }

        if (state is ItemsLoaded) {
          return BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, favState) {
              final favoriteIds = favState is FavoritesLoaded
                  ? favState.favorites.map((f) => f.id).toSet()
                  : <int>{};

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ItemsBloc>().add(RefreshCharacters());
                },
                child: Column(
                  children: [
                    if (state.isOffline)
                      Container(
                        color: Colors.orange,
                        padding: const EdgeInsets.all(8),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wifi_off, size: 16, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Offline — showing cached data',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8),
                        itemCount: state.hasReachedMax
                            ? state.characters.length
                            : state.characters.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.characters.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          final character = state.characters[index];
                          return CharacterCard(
                            character: character,
                            isFavorite: favoriteIds.contains(character.id),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ItemDetailPage(character: character),
                              ),
                            ),
                            onFavoriteToggle: () {
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
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
