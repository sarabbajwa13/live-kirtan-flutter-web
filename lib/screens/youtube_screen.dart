import 'package:flutter/material.dart';
import 'package:live_kirtan/widgets/nuephormic_button.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

class YouTubeScreen extends StatelessWidget {
  const YouTubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      body: Container(
        color: Colors.black,
        
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    NeumorphicButton(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black87,
                        size: 18,
                      ),
                      backgroundColor: bgColor,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Live Kirtan',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: YouTubeWebEmbed(videoId: 'LTU5u67cuck'), // Use your video ID here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YouTubeWebEmbed extends StatelessWidget {
  final String videoId;
  const YouTubeWebEmbed({required this.videoId, super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'youtube-iframe-$videoId',
      (int viewId) => IFrameElement()
        ..width = '100%'
        ..height = '100%'
        ..src = 'https://www.youtube.com/embed/$videoId?autoplay=1&controls=0'
        ..style.border = 'none',
    );
    return HtmlElementView(viewType: 'youtube-iframe-$videoId');
  }
} 