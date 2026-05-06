import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/drawer.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _debounce;
  StreamSubscription? _connectionSubscription;

  final List<String> categories = [
    "home",
    "world",
    "science",
    "sports",
    "arts"
  ];

  // 🌍 COUNTRY LIST
  final List<String> countries = ["in", "us", "gb", "au"];
  String selectedCountry = "in";

  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<NewsProvider>(context, listen: false);

    Future.microtask(() {
      provider.country = selectedCountry;
      provider.loadInitial();
    });
    _connectionSubscription =
        Connectivity().onConnectivityChanged.listen((result) {
          print("Connection changed: $result");
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
      drawer: const AppDrawer(),
      body: Column(
        children: [
          _buildTopFilter(provider),
          _buildCategories(provider),
          Expanded(child: _buildNewsList(provider)),
        ],
      ),
    );
  }

  // 🔥 APP BAR
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
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
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
        ],
      ),
    );
  }

  // 🌍 COUNTRY DROPDOWN
  Widget _buildTopFilter(NewsProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.public, size: 20),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: selectedCountry,
            items: countries.map((c) {
              return DropdownMenuItem(
                value: c,
                child: Text(c.toUpperCase()),
              );
            }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value!;
                });

                // 🔥 debounce logic
                if (_debounce?.isActive ?? false) _debounce!.cancel();

                _debounce = Timer(const Duration(milliseconds: 800), () {
                  provider.changeCountry(selectedCountry);
                });
              }
          ),
        ],
      ),
    );
  }

  // 📂 CATEGORY CHIPS
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
                onSelected: (_) async {
                  if (provider.category != cat) {
                    await provider.filterByCategory(cat);
                  }
                }
            ),
          );
        },
      ),
    );
  }

  // 📰 NEWS LIST
  Widget _buildNewsList(NewsProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.articles.isEmpty) {
      return const Center(
        child: Text("No news available 😢"),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1)); // 🔥 delay
        await provider.refresh();
      },
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                article.author.isNotEmpty
                                    ? article.author
                                    : "Unknown",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(article.date),
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