import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const playlistUrl =
    'https://open.spotify.com/playlist/6UzK2D1usGFK4gAAsbLzP6';
const green = Color(0xFF1DB954);
const bg = Color(0xFF121212);

void main() => runApp(const MusicApp());

class Song {
  final String title, artist, lang;
  final int secs;
  const Song(this.title, this.artist, this.lang, this.secs);

  String get searchUrl =>
      'https://open.spotify.com/search/${Uri.encodeComponent('$title $artist')}';

  int get _seed => title.codeUnits.fold(0, (a, b) => a + b);
  Color get color =>
      HSLColor.fromAHSL(1, (_seed * 7 % 360).toDouble(), 0.62, 0.36).toColor();
  Color get color2 =>
      HSLColor.fromAHSL(1, ((_seed * 7 + 50) % 360).toDouble(), 0.7, 0.22)
          .toColor();
  String get imageUrl =>
      'https://picsum.photos/seed/${Uri.encodeComponent(title)}/300/300';
}

const songs = <Song>[
  // Hindi
  Song('Kesariya', 'Arijit Singh', 'Hindi', 268),
  Song('Tum Hi Ho', 'Arijit Singh', 'Hindi', 262),
  Song('Channa Mereya', 'Arijit Singh', 'Hindi', 289),
  Song('Raataan Lambiyan', 'Jubin Nautiyal, Asees Kaur', 'Hindi', 230),
  Song('Tere Vaaste', 'Varun Jain, Sachin-Jigar', 'Hindi', 262),
  Song('Kahani Suno 2.0', 'Kaifi Khalil', 'Hindi', 183),
  Song('Heeriye', 'Jasleen Royal, Arijit Singh', 'Hindi', 196),
  Song('Chaleya', 'Arijit Singh, Shilpa Rao', 'Hindi', 200),
  Song('Apna Bana Le', 'Arijit Singh', 'Hindi', 261),
  Song('Pehle Bhi Main', 'Vishal Mishra', 'Hindi', 264),
  Song('Tauba Tauba', 'Karan Aujla', 'Hindi', 211),
  Song('Aaj Ki Raat', 'Madhubanti Bagchi, Divya Kumar', 'Hindi', 191),
  Song('Saiyaara', 'Faheem Abdullah, Arslan Nizami', 'Hindi', 232),
  Song('Husn', 'Anuv Jain', 'Hindi', 195),
  // English
  Song('Blinding Lights', 'The Weeknd', 'English', 200),
  Song('Shape of You', 'Ed Sheeran', 'English', 234),
  Song('Perfect', 'Ed Sheeran', 'English', 263),
  Song('Believer', 'Imagine Dragons', 'English', 204),
  Song('Someone You Loved', 'Lewis Capaldi', 'English', 182),
  Song('Levitating', 'Dua Lipa', 'English', 203),
  Song('As It Was', 'Harry Styles', 'English', 167),
  Song('Flowers', 'Miley Cyrus', 'English', 200),
  Song('Espresso', 'Sabrina Carpenter', 'English', 175),
  Song('Die With A Smile', 'Lady Gaga, Bruno Mars', 'English', 252),
  Song('BIRDS OF A FEATHER', 'Billie Eilish', 'English', 210),
  Song('APT.', 'ROSÉ, Bruno Mars', 'English', 169),
  Song('Beautiful Things', 'Benson Boone', 'English', 180),
  Song('Not Like Us', 'Kendrick Lamar', 'English', 274),
  // Telugu
  Song('Butta Bomma', 'Armaan Malik', 'Telugu', 198),
  Song('Ramuloo Ramulaa', 'Anurag Kulkarni, Mangli', 'Telugu', 218),
  Song('Srivalli', 'Sid Sriram (Pushpa)', 'Telugu', 233),
  Song('Naatu Naatu', 'Rahul Sipligunj, Kaala Bhairava', 'Telugu', 217),
  Song('Oo Antava', 'Indravathi Chauhan (Pushpa)', 'Telugu', 223),
  Song('Samajavaragamana', 'Sid Sriram', 'Telugu', 240),
  Song('Inkem Inkem Kavale', 'Sid Sriram', 'Telugu', 258),
  Song('Kurchi Madathapetti', 'Guntur Kaaram', 'Telugu', 213),
  Song('Chuttamalle', 'Shilpa Rao (Devara)', 'Telugu', 223),
  Song('Kissik', 'Sublahshini (Pushpa 2)', 'Telugu', 218),
  Song('Peelings', 'Pushpa 2', 'Telugu', 233),
  Song('Sooseki', 'Shreya Ghoshal (Pushpa 2)', 'Telugu', 243),
  // Tamil
  Song('Why This Kolaveri Di', 'Dhanush', 'Tamil', 249),
  Song('Rowdy Baby', 'Dhanush, Dhee', 'Tamil', 223),
  Song('Vaathi Coming', 'Anirudh Ravichander (Master)', 'Tamil', 200),
  Song('Arabic Kuthu', 'Anirudh, Jonita Gandhi (Beast)', 'Tamil', 276),
  Song('Kaavaalaa', 'Shilpa Rao (Jailer)', 'Tamil', 197),
  Song('Hukum', 'Anirudh Ravichander (Jailer)', 'Tamil', 212),
  Song('Ranjithame', 'Vijay, M.M. Manasi (Varisu)', 'Tamil', 238),
  Song('Enjoy Enjaami', 'Dhee, Arivu', 'Tamil', 288),
  Song('Whistle Podu', 'Vijay (The GOAT)', 'Tamil', 214),
  Song('Chikitu', 'Anirudh Ravichander (Coolie)', 'Tamil', 215),
  Song('Monica', 'Anirudh Ravichander (Coolie)', 'Tamil', 235),
];

const filters = ['All', 'Hindi', 'English', 'Telugu', 'Tamil', 'Favorites'];
const playlistNames = {
  'All': 'Top Hits Mix',
  'Hindi': 'Hindi Top Hits',
  'English': 'English Top Hits',
  'Telugu': 'Telugu Top Hits',
  'Tamil': 'Tamil Top Hits',
  'Favorites': 'Liked Songs',
};
const tints = {
  'All': Color(0xFF1E6B45),
  'Hindi': Color(0xFF9A3412),
  'English': Color(0xFF166534),
  'Telugu': Color(0xFF5B21B6),
  'Tamil': Color(0xFF0B5CAD),
  'Favorites': Color(0xFF6D28D9),
};

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TuneWave',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(primary: green),
        ),
        home: const HomePage(),
      );
}

class Cover extends StatelessWidget {
  final Song song;
  final double size;
  final double radius;
  const Cover(this.song, {super.key, this.size = 48, this.radius = 6});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(fit: StackFit.expand, children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [song.color, song.color2]),
              ),
              child: Center(
                  child: Icon(Icons.music_note,
                      color: Colors.white24, size: size * 0.45)),
            ),
            Image.network(
              song.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              loadingBuilder: (_, child, p) =>
                  p == null ? child : const SizedBox.shrink(),
            ),
          ]),
        ),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage>
