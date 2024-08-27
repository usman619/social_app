import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/components/app_user_tile.dart';
import 'package:social_app/services/database/database_provider.dart';
import 'package:social_app/themes/text_theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    final listeningProvider = Provider.of<DatabaseProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: titleTextTheme.copyWith(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            border: InputBorder.none,
          ),
          style: bodyTextTheme,
          // Search for Users
          onChanged: (value) {
            if (value.isNotEmpty) {
              databaseProvider.searchUsers(value);
            } else {
              databaseProvider.searchUsers("");
            }
          },
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
        // centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: listeningProvider.searchResults.isEmpty
          ? Center(
              child: Text(
                'User not found',
                style: bodyTextTheme,
              ),
            )
          : ListView.builder(
              itemCount: listeningProvider.searchResults.length,
              itemBuilder: (context, index) {
                final user = listeningProvider.searchResults[index];
                return AppUserTile(user: user);
              },
            ),
    );
  }
}
