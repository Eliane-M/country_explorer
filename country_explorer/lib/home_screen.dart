import 'package:flutter/material.dart';
import 'news_service.dart';
import 'package:country_explorer/details_screen.dart';

class HomeScreen extends StatelessWidget {
  final NewsService newsService = NewsService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Headlines')),
      body: FutureBuilder(
        future: newsService.fetchTopHeadlines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final articles = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  leading: article['urlToImage'] != null
                      ? Image.network(article['urlToImage'],
                          width: 100, fit: BoxFit.cover)
                      : null,
                  title: Text(article['title']),
                  subtitle: Text(article['description'] ?? 'No description'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(article: article),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
