import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/drawer.dart';
import 'LikedScreen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? _connectionSubscription;

  final List<String> categories = [
    "home",
    "world",
    "science",
    "sports",
    "arts"
  ];

  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override

  void initState() {
    super.initState();
    final provider = Provider.of<NewsProvider>(context, listen: false);
    Future.microtask(() {
      provider.fetchNews("home");
    });
    _connectionSubscription = Connectivity().onConnectivityChanged.listen((result) {
          if (result != ConnectivityResult.none) {
            provider.fetchNews(provider.category);
          }
        });
  }
  @override
  void dispose() {
    _connectionSubscription?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: AppDrawer(),
      body: Column(
        children: [
          _buildCategories(provider),
          Expanded(child: _buildNewsList(provider)),
        ],
      ),
    );
  }
  PreferredSizeWidget _buildAppBar() {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search news...",
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            Provider.of<NewsProvider>(context, listen: false)
                .search(value);
          },
        )
            : const Text(
          "News Explorer",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),

        actions: [

          // 🔍 SEARCH BUTTON
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;

                if (!isSearching) {
                  searchController.clear();
                  Provider.of<NewsProvider>(context, listen: false)
                      .search("");
                }
              });
            },
          ),

          // 🌙 THEME BUTTON
          IconButton(
            icon: Icon(
              themeProvider.isDark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),

          const SizedBox(width: 8),
        ],

        // 🔥 BOTTOM LINE (premium touch)
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildCategories(NewsProvider provider) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = provider.category == cat;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (_) => provider.fetchNews(cat),
            ),
          );
        },
      ),
    );
  }
  Widget _buildNewsList(NewsProvider provider) {

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.articles.isEmpty) {
      return const Center(child: Text("No articles found"));
    }
    return RefreshIndicator(
      onRefresh: () => provider.fetchNews(provider.category),
      child: ListView.builder(
        itemCount: provider.articles.length,
        itemBuilder: (context, index) {
          final article = provider.articles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(article: article),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.image.isNotEmpty)
                    Image.network(
                      article.image,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              article.author.isNotEmpty
                                  ? article.author
                                  : "Unknown",
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              article.date,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}