import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const playlistUrl =
    'https://open.spotify.com/playlist/6UzK2D1usGFK4gAAsbLzP6';

void main() => runApp(const MusicApp());

class Song {
  final String title, artist, lang;
  final int secs;
  const Song(this.title, this.artist, this.lang, this.secs);
  String get searchUrl => 'https://open.spotify.com/search/'
      '${Uri.encodeComponent('$title $artist')}';
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

const langColors = {
  'Hindi': [Color(0xFFFF7A18), Color(0xFFAF002D)],
  'English': [Color(0xFF1DB954), Color(0xFF0B5D3B)],
  'Telugu': [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
  'Tamil': [Color(0xFF00C6FF), Color(0xFF0072FF)],
};

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TuneWave',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: const Color(0xFF121212),
          colorScheme: const ColorScheme.dark(primary: Color(0xFF1DB954)),
        ),
        home: const PlaylistPage(),
      );
}

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});
  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  String filter = 'All';
  String query = '';
  Song? current;
  bool playing = false;
  int elapsed = 0;
  final Set<Song> favs = {};
  Timer? timer;

  final filters = const [
    'All', 'Hindi', 'English', 'Telugu', 'Tamil', 'Favorites'
  ];

  List<Song> get visible => songs.where((s) {
        final okFilter = filter == 'All' ||
            (filter == 'Favorites' ? favs.contains(s) : s.lang == filter);
        final q = query.toLowerCase();
        final okQuery = q.isEmpty ||
            s.title.toLowerCase().contains(q) ||
            s.artist.toLowerCase().contains(q);
        return okFilter && okQuery;
      }).toList();

  void play(Song s) {
    timer?.cancel();
    setState(() {
      current = s;
      elapsed = 0;
      playing = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !playing || current == null) return;
      if (elapsed >= current!.secs) {
        step(1);
      } else {
        setState(() => elapsed++);
      }
    });
  }

  void step(int d) {
    final list = visible;
    if (list.isEmpty) return;
    final i = current == null ? -1 : list.indexOf(current!);
    play(list[(i + d + list.length) % list.length]);
  }

  void toggle() {
    if (current == null) return;
    setState(() => playing = !playing);
  }

  String fmt(int s) => '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';

  Future<void> open(String url) =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = visible;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          _header(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                hintText: 'Search songs or artists',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: filters
                  .map((f) => Padding(
                        padding: const EdgeInsets.all(6),
                        child: ChoiceChip(
                          label: Text(f),
                          selected: filter == f,
                          onSelected: (_) => setState(() => filter = f),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: list.isEmpty
                ? const Center(child: Text('No songs found'))
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, i) => _tile(list[i]),
                  ),
          ),
          if (current != null) _player(),
        ]),
      ),
    );
  }

  Widget _header() => Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xFF1DB954), Color(0xFF191414)]),
        ),
        child: Row(children: [
          const Icon(Icons.queue_music, size: 56),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TuneWave',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('${songs.length} songs · Hindi · English · Telugu · Tamil',
                      style: const TextStyle(color: Colors.white70)),
                ]),
          ),
          TextButton.icon(
            onPressed: () => open(playlistUrl),
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('Spotify'),
          ),
        ]),
      );

  Widget _tile(Song s) {
    final isCur = s == current;
    final colors = langColors[s.lang]!;
    return ListTile(
      selected: isCur,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: colors)),
        child: Icon(isCur && playing ? Icons.graphic_eq : Icons.music_note),
      ),
      title: Text(s.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${s.artist} · ${s.lang}',
          maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          icon: Icon(favs.contains(s) ? Icons.favorite : Icons.favorite_border,
              color: favs.contains(s) ? Colors.redAccent : null),
          onPressed: () => setState(
              () => favs.contains(s) ? favs.remove(s) : favs.add(s)),
        ),
        Text(fmt(s.secs), style: const TextStyle(color: Colors.white54)),
      ]),
      onTap: () => play(s),
    );
  }

  Widget _player() {
    final s = current!;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      color: const Color(0xFF1E1E1E),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                  Text(s.artist,
                      style: const TextStyle(color: Colors.white60),
                      overflow: TextOverflow.ellipsis),
                ]),
          ),
          IconButton(
              icon: const Icon(Icons.skip_previous), onPressed: () => step(-1)),
          IconButton(
            iconSize: 40,
            icon: Icon(playing ? Icons.pause_circle : Icons.play_circle),
            onPressed: toggle,
          ),
          IconButton(icon: const Icon(Icons.skip_next), onPressed: () => step(1)),
          IconButton(
              tooltip: 'Open in Spotify',
              icon: const Icon(Icons.open_in_new),
              onPressed: () => open(s.searchUrl)),
        ]),
        Row(children: [
          Text(fmt(elapsed), style: const TextStyle(fontSize: 12)),
          Expanded(
            child: Slider(
              value: elapsed.clamp(0, s.secs).toDouble(),
              max: s.secs.toDouble(),
              onChanged: (v) => setState(() => elapsed = v.toInt()),
            ),
          ),
          Text(fmt(s.secs), style: const TextStyle(fontSize: 12)),
        ]),
      ]),
    );
  }
}
