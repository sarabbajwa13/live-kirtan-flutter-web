import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:live_kirtan/utils/constants.dart';
import 'package:live_kirtan/widgets/nuephormic_button.dart';
import 'package:live_kirtan/widgets/nuephormic_container.dart';
import 'package:live_kirtan/screens/youtube_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Kirtan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF6F8FB),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Colors.black45,
          ),
        ),
      ),
      home: const AudioPlayerPage(),
    );
  }
}

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final String _streamUrl = 'https://live.sgpc.net:8442/;%20nocache=889869';
  bool _isPlaying = false;
  bool _isLoading = false;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  @override
  void initState() {
    super.initState();
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      final isLoading = (state.processingState == ProcessingState.loading ||
                        state.processingState == ProcessingState.buffering) &&
                       !state.playing;
      final isPlaying = state.playing;
      if (mounted && (isLoading != _isLoading || isPlaying != _isPlaying)) {
        setState(() {
          _isLoading = isLoading;
          _isPlaying = isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } else {
      try {
        await _audioPlayer.setUrl(_streamUrl);
        await _audioPlayer.play();
      } catch (e) {
        setState(() {
          _isPlaying = false;
          _isLoading = false;
        });
        debugPrint('Error playing audio: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_img.jpg'),
            fit: BoxFit.cover,
            opacity: 0.3
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Album Art
                    NeumorphicContainer(
                      padding: const EdgeInsets.all(5),
                      borderRadius: 220,
                      backgroundColor: bgColor,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/background_img.jpg',
                          width: 220,
                          height: 220,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Song Title with Gradient
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Colors.black87, Colors.black54],
                      ).createShader(bounds),
                      child: Text(
                        'Live Kirtan',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                           const SizedBox(height: 10),
                    // Subtitle with enhanced styling
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Sri Harimandir Sahib',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 64),
                    // Enhanced Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeumorphicButton(
                          onTap: _isLoading ? null : _toggleAudio,
                          child: _isLoading
                              ? SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                                  ),
                                )
                              : Icon(
                                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  size: 40,
                                  color: Colors.black87,
                                ),
                          backgroundColor: bgColor,
                        ),
                        const SizedBox(width: 20),
                        NeumorphicButton(
                          onTap: () async {
                            await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const YouTubeScreen()),
                            );
                          },
                          child: Icon(
                            Icons.live_tv_rounded,
                            size: 40,
                            color: Colors.black87,
                          ),
                          backgroundColor: bgColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
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

