import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const playlistUrl =
    'https://open.spotify.com/playlist/6UzK2D1usGFK4gAAsbLzP6';
const green = Color(0xFF78F0B5);
const bg = Color(0xFF111A20);

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
  // Additional curated picks; durations are approximate UI values.
  Song('O Maahi', 'Arijit Singh', 'Hindi', 233),
  Song('Satranga', 'Arijit Singh', 'Hindi', 271),
  Song('Shayad', 'Arijit Singh', 'Hindi', 248),
  Song('Agar Tum Saath Ho', 'Alka Yagnik, Arijit Singh', 'Hindi', 341),
  Song('Ilahi', 'Arijit Singh', 'Hindi', 228),
  Song('Kabira', 'Tochi Raina, Rekha Bhardwaj', 'Hindi', 223),
  Song('Badtameez Dil', 'Benny Dayal, Shefali Alvares', 'Hindi', 252),
  Song('Besharam Rang', 'Shilpa Rao', 'Hindi', 258),
  Song('Jhoome Jo Pathaan', 'Arijit Singh, Sukriti Kakar', 'Hindi', 208),
  Song('Ghungroo', 'Arijit Singh, Shilpa Rao', 'Hindi', 302),
  Song('Nashe Si Chadh Gayi', 'Arijit Singh', 'Hindi', 237),
  Song('Hawayein', 'Arijit Singh', 'Hindi', 289),
  Song('Ranjha', 'B Praak, Jasleen Royal', 'Hindi', 228),
  Song('Mann Bharryaa 2.0', 'B Praak', 'Hindi', 266),
  Song('Pasoori', 'Ali Sethi, Shae Gill', 'Hindi', 224),
  Song('Sajni', 'Arijit Singh', 'Hindi', 170),
  Song('Ve Kamleya', 'Arijit Singh, Shreya Ghoshal', 'Hindi', 246),
  Song('Tainu Khabar Nahi', 'Arijit Singh', 'Hindi', 248),
  Song('Akhiyaan Gulaab', 'Mitraz', 'Hindi', 171),
  Song('Aayi Nai', 'Pawan Singh, Simran Choudhary', 'Hindi', 178),
  Song('Starboy', 'The Weeknd, Daft Punk', 'English', 230),
  Song('Save Your Tears', 'The Weeknd', 'English', 215),
  Song('Die For You', 'The Weeknd', 'English', 260),
  Song('Sunflower', 'Post Malone, Swae Lee', 'English', 158),
  Song('Circles', 'Post Malone', 'English', 215),
  Song('Stay', 'The Kid LAROI, Justin Bieber', 'English', 141),
  Song('Heat Waves', 'Glass Animals', 'English', 239),
  Song('Sweater Weather', 'The Neighbourhood', 'English', 240),
  Song('Night Changes', 'One Direction', 'English', 227),
  Song('What Makes You Beautiful', 'One Direction', 'English', 199),
  Song('Dynamite', 'BTS', 'English', 199),
  Song('Butter', 'BTS', 'English', 164),
  Song('Seven', 'Jung Kook, Latto', 'English', 184),
  Song('Cruel Summer', 'Taylor Swift', 'English', 178),
  Song('Blank Space', 'Taylor Swift', 'English', 231),
  Song('Anti-Hero', 'Taylor Swift', 'English', 200),
  Song('Vampire', 'Olivia Rodrigo', 'English', 219),
  Song('Good 4 U', 'Olivia Rodrigo', 'English', 178),
  Song('Lose Control', 'Teddy Swims', 'English', 210),
  Song('Please Please Please', 'Sabrina Carpenter', 'English', 186),
  Song('Vachinde', 'Madhu Priya, Ramky', 'Telugu', 322),
  Song('Hey Pillagaada', 'Sinduri, Sinov Raj', 'Telugu', 248),
  Song('Maate Vinadhuga', 'Sid Sriram', 'Telugu', 265),
  Song('Undiporaadhey', 'Sid Sriram', 'Telugu', 173),
  Song('Adiga Adiga', 'Sid Sriram', 'Telugu', 213),
  Song('Em Sandeham Ledu', 'Kalyan Koduri, Sunitha', 'Telugu', 235),
  Song('Yenti Yenti', 'Chinmayi Sripada', 'Telugu', 206),
  Song('Vachindamma', 'Sid Sriram', 'Telugu', 250),
  Song('Nee Kannu Neeli Samudram', 'Javed Ali', 'Telugu', 312),
  Song('Dhivara', 'Ramya Behara, Deepu', 'Telugu', 343),
  Song('Dosti', 'Hemachandra', 'Telugu', 340),
  Song('Komuram Bheemudo', 'Kaala Bhairava', 'Telugu', 254),
  Song('Oh Sita Hey Rama', 'S P Charan, Ramya Behara', 'Telugu', 246),
  Song('Inthandham', 'Vishal Chandrashekhar, S P Charan', 'Telugu', 218),
  Song('Kaanunna Kalyanam', 'Anurag Kulkarni, Sinduri', 'Telugu', 232),
  Song('Priyathama Priyathama', 'Chinmayi Sripada', 'Telugu', 245),
  Song('Choosi Chudangane', 'Anurag Kulkarni', 'Telugu', 201),
  Song('Pilla Raa', 'Anurag Kulkarni', 'Telugu', 236),
  Song('Saranga Dariya', 'Mangli', 'Telugu', 230),
  Song('Chitti', 'Ram Miriyala', 'Telugu', 209),
  Song('Naa Ready', 'Vijay, Anirudh Ravichander, Asal Kolaar', 'Tamil', 248),
  Song('Badass', 'Anirudh Ravichander', 'Tamil', 229),
  Song('Ordinary Person', 'Nikhita Gandhi', 'Tamil', 138),
  Song('Anbenum', 'Anirudh Ravichander, Lothika', 'Tamil', 214),
  Song('Megham Karukatha', 'Dhanush', 'Tamil', 290),
  Song('Thenmozhi', 'Santhosh Narayanan', 'Tamil', 173),
  Song('Maruvaarthai', 'Sid Sriram', 'Tamil', 356),
  Song('Thalli Pogathey', 'Sid Sriram, Aaryan Dinesh Kanagaratnam', 'Tamil', 267),
  Song('Munbe Vaa', 'Shreya Ghoshal, Naresh Iyer', 'Tamil', 359),
  Song('New York Nagaram', 'A R Rahman', 'Tamil', 379),
  Song('Pachai Nirame', 'Hariharan, Clinton Cerejo', 'Tamil', 358),
  Song('Aaluma Doluma', 'Anirudh Ravichander, Badshah', 'Tamil', 258),
  Song('Donu Donu Donu', 'Anirudh Ravichander, Alisha Thomas', 'Tamil', 195),
  Song('Chellamma', 'Anirudh Ravichander, Jonita Gandhi', 'Tamil', 236),
  Song('So Baby', 'Anirudh Ravichander, Ananthakrrishnan', 'Tamil', 232),
  Song('Pathala Pathala', 'Kamal Haasan', 'Tamil', 210),
  Song('Once Upon a Time', 'Anirudh Ravichander', 'Tamil', 143),
  Song('Vikram Title Track', 'Anirudh Ravichander', 'Tamil', 218),
  Song('Nenjukkul Peidhidum', 'Hariharan, Devan Ekambaram, V Prasanna', 'Tamil', 369),
  Song('Vaseegara', 'Bombay Jayashri', 'Tamil', 299),
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
          scaffoldBackgroundColor: const Color(0xFF090F14),
          colorScheme: const ColorScheme.dark(primary: green),
        ),
        home: const HomePage(),
      );
}
class Cover extends StatelessWidget {
  final Song song;
  final double size;
  final double radius;
  const Cover(this.song, {super.key, this.size = 48, this.radius = 10});
  @override
  Widget build(BuildContext context) => Semantics(
    label: '${song.title} artwork',
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [song.color, song.color2, const Color(0xFF10262D)])),
        child: Stack(alignment: Alignment.center, children: [
          Positioned(right: -size * .28, top: -size * .1,
            child: Container(width: size, height: size,
              decoration: BoxDecoration(shape: BoxShape.circle,
                border: Border.all(color: Colors.white12, width: size * .10)))),
          Container(width: size * .65, height: size * .65,
            decoration: BoxDecoration(shape: BoxShape.circle,
              color: Colors.black38,
              border: Border.all(color: Colors.white24, width: 1)),
            child: Center(child: Container(width: size * .19, height: size * .19,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: green),
              child: Center(child: Container(width: size * .05, height: size * .05,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: bg)))))),
          if (size > 90) Positioned(left: 14, bottom: 13, right: 12,
            child: Text(song.title.toUpperCase(), maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w900,
                fontSize: size * .075, letterSpacing: 2))),
        ]),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filter = 'All';
  String query = '';
  Song? current;
  bool playing = false;
  bool shuffle = false;
  bool repeat = false;
  int elapsed = 0;
  double volume = 0.7;
  final Set<Song> favs = {};
  final searchFocus = FocusNode();
  final searchController = TextEditingController();
  final rnd = Random();
  Timer? timer;
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
        repeat ? play(current!) : step(1);
      } else {
        setState(() => elapsed++);
      }
    });
  }
  void step(int d) {
    final list = visible;
    if (list.isEmpty) return;
    final i = current == null ? -1 : list.indexOf(current!);
    if (shuffle && d > 0 && list.length > 1) {
      var n = rnd.nextInt(list.length);
      while (n == i) {
        n = rnd.nextInt(list.length);
      }
      play(list[n]);
    } else {
      play(list[(i + d + list.length) % list.length]);
    }
  }
  void togglePlay() {
    if (current == null) {
      final l = visible;
      if (l.isNotEmpty) play(l.first);
      return;
    }
    setState(() => playing = !playing);
  }

  void toggleFav(Song s) =>
      setState(() => favs.contains(s) ? favs.remove(s) : favs.add(s));

  String fmt(int s) => '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';

  Future<void> open(String url) async {
    try {
      final opened = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Spotify. Please try again.')));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Spotify. Please try again.')));
      }
    }
  }
  @override
  void dispose() {
    timer?.cancel();
    searchFocus.dispose();
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, c) {
          final wide = c.maxWidth >= 1000;
          if (wide) {
            return Column(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(children: [
                    _sidebar(),
                    const SizedBox(width: 16),
                    Expanded(child: _main(true)),
                  ]),
                ),
              ),
              _desktopPlayer(),
            ]);
          }
          return Column(children: [
            Expanded(child: _main(false)),
            if (current != null) _mobilePlayer(),
          ]);
        }),
      ),
    );
  }
  // ---------------- Sidebar ----------------
  Widget _sidebar() => SizedBox(
        width: 238,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: const [
                Icon(Icons.graphic_eq, color: green, size: 30),
                SizedBox(width: 8),
                Text('TuneWave',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5)),
              ]),
              const SizedBox(height: 16),
              _navItem(Icons.home_filled, 'Home', filter == 'All' && query.isEmpty,
                  () => setState(() {
                        filter = 'All';
                        query = '';
                        searchController.clear();
                      })),
              _navItem(Icons.search, 'Search', false,
                  () => searchFocus.requestFocus()),
            ]),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: bg, borderRadius: BorderRadius.circular(12)),
              child: ListView(padding: const EdgeInsets.all(8), children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(children: [
                    Icon(Icons.library_music, color: Colors.white70),
                    SizedBox(width: 10),
                    Text('Your Library',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white70)),
                  ]),
                ),
                ...filters.map((f) {
                  final selected = filter == f;
                  final count = f == 'All'
                      ? songs.length
                      : f == 'Favorites'
                          ? favs.length
                          : songs.where((s) => s.lang == f).length;
                  return GestureDetector(
                    onTap: () => setState(() => filter = f),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: selected ? Colors.white12 : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(colors: [
                              tints[f]!,
                              tints[f]!.withOpacity(0.5)
                            ]),
                          ),
                          child: Icon(
                              f == 'Favorites'
                                  ? Icons.favorite
                                  : Icons.library_music,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(playlistNames[f]!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: selected ? green : Colors.white)),
                                Text('Playlist · $count songs',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white54)),
                              ]),
                        ),
                      ]),
                    ),
                  );
                }),
              ]),
            ),
          ),
        ]),
      );
  Widget _navItem(IconData i, String t, bool active, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(children: [
            Icon(i, color: active ? Colors.white : Colors.white60),
            const SizedBox(width: 16),
            Text(t,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: active ? Colors.white : Colors.white60)),
          ]),
        ),
      );
  // ---------------- Main panel ----------------
  Widget _main(bool wide) {
    final list = visible;
    final pad = wide ? 30.0 : 18.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(wide ? 20 : 0),
      child: Container(color: bg, child: ListView(
        padding: EdgeInsets.fromLTRB(pad, 24, pad, 24),
        children: [
          _topBar(wide),
          const SizedBox(height: 28),
          _hero(wide, list),
          const SizedBox(height: 30),
          Row(children: [
            const Expanded(child: Text('Find your rhythm',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800))),
            Text('4 languages', style: TextStyle(color: Colors.white54,
              fontSize: wide ? 13 : 11)),
          ]),
          const SizedBox(height: 14),
          _collections(),
          const SizedBox(height: 26),
          Row(children: [
            Expanded(child: Text(playlistNames[filter]!,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800))),
            Text('${list.length} tracks',
              style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ]),
          const SizedBox(height: 8),
          _chips(),
          if (query.trim().isNotEmpty) Align(alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => open('https://open.spotify.com/search/${Uri.encodeComponent(query.trim())}'),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Find more songs on Spotify'))),
          const SizedBox(height: 10),
          _actions(list),
          const SizedBox(height: 8),
          const Text('Player preview \u00b7 Listen to full songs on Spotify',
            style: TextStyle(fontSize: 11, color: Colors.white54)),
          const SizedBox(height: 12),
          _tableHeader(wide),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 8),
          if (list.isEmpty) Padding(
            padding: const EdgeInsets.symmetric(vertical: 36),
            child: Column(children: [
              Icon(filter == 'Favorites' ? Icons.favorite_border : Icons.search_off,
                size: 42, color: green),
              const SizedBox(height: 12),
              Text(filter == 'Favorites' ? 'Your favourites start here' : 'No tracks found',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(filter == 'Favorites' ? 'Tap a heart to save a song for this session.'
                : 'Try another title, artist or language.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white60)),
              TextButton(onPressed: () { searchController.clear();
                setState(() { filter = 'All'; query = ''; }); },
                child: const Text('Browse all songs')),
            ])),
          for (int i = 0; i < list.length; i++) SongRow(
            index: i, song: list[i], isCurrent: list[i] == current,
            playing: playing, liked: favs.contains(list[i]), wide: wide,
            duration: fmt(list[i].secs), onTap: () => play(list[i]),
            onLike: () => toggleFav(list[i])),
          const SizedBox(height: 24),
          const Text('Made for every mood. Built with Flutter.',
            style: TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      )),
    );
  }

  Widget _topBar(bool wide) => Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        if (!wide) ...[
          const Icon(Icons.graphic_eq, color: green, size: 28),
          const SizedBox(width: 8),
          const Text('TuneWave', style: TextStyle(fontSize: 22,
            fontWeight: FontWeight.w900, letterSpacing: -1)),
        ] else const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('YOUR DAILY SOUNDTRACK',
            style: TextStyle(fontSize: 10, letterSpacing: 2, color: green)),
          SizedBox(height: 5),
          Text('A little music. A better day.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ]),
        const Spacer(),
        const CircleAvatar(radius: 18, backgroundColor: Color(0xFF263C36),
          child: Icon(Icons.headphones, size: 19, color: green)),
      ]),
      const SizedBox(height: 20),
      TextField(controller: searchController, focusNode: searchFocus,
        onChanged: (v) => setState(() => query = v),
        decoration: InputDecoration(
          hintText: 'Search your next favourite song',
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Colors.white60),
          suffixIcon: query.isEmpty ? null : IconButton(
            tooltip: 'Clear search', icon: const Icon(Icons.close, size: 18),
            onPressed: () { searchController.clear(); setState(() => query = ''); }),
          filled: true, fillColor: const Color(0xFF1B252D),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.white12)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.white12)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: green)),
        )),
    ]);

  Widget _collections() => SizedBox(height: 126,
    child: ListView.separated(scrollDirection: Axis.horizontal,
      itemCount: 4, separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, i) {
        final lang = filters[i + 1];
        final subtitles = ['Soulful & timeless', 'On repeat, always', 'Feel the energy', 'Turn up the vibe'];
        final icons = [Icons.wb_twilight, Icons.nightlight_round,
          Icons.bolt, Icons.graphic_eq];
        return SizedBox(width: 174, child: Material(
          color: Colors.transparent, borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Ink(decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tints[lang]!, const Color(0xFF18252B)]),
            border: Border.all(color: filter == lang ? green : Colors.white12),
            borderRadius: BorderRadius.circular(16)),
            child: InkWell(onTap: () => setState(() => filter = lang),
              child: Padding(padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [Icon(icons[i], color: Colors.white70, size: 24),
                      const Spacer(), const Icon(Icons.arrow_outward, size: 16,
                        color: Colors.white60)]),
                    const Spacer(),
                    Text(lang, style: const TextStyle(fontSize: 19,
                      fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text(subtitles[i], style: const TextStyle(
                      color: Colors.white70, fontSize: 11)),
                  ])),
            )),
        ));
      }));

  Widget _chips() => SizedBox(
        height: 52,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: filters
              .map((f) => Padding(
                    padding: const EdgeInsets.only(right: 8, top: 10, bottom: 6),
                    child: ChoiceChip(
                      label: Text(f),
                      selected: filter == f,
                      showCheckmark: false,
                      selectedColor: green,
                      labelStyle: TextStyle(
                          color: filter == f ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600),
                      backgroundColor: Colors.white12,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                      onSelected: (_) => setState(() => filter = f),
                    ),
                  ))
              .toList(),
        ),
      );
  Widget _hero(bool wide, List<Song> list) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 600;
      return Container(
        padding: EdgeInsets.all(compact ? 24 : 32),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF22564E), Color(0xFF142D36), Color(0xFF172333)]),
          border: Border.all(color: const Color(0xFF345D59))),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(children: [Icon(Icons.auto_awesome, size: 15, color: green),
                SizedBox(width: 7), Text('THE TUNEWAVE MIX',
                  style: TextStyle(fontSize: 10, letterSpacing: 2,
                    fontWeight: FontWeight.w700, color: green))]),
              const SizedBox(height: 18),
              Text('Your mood.\nYour music.', style: TextStyle(
                fontSize: compact ? 38 : 50, height: 1.05,
                letterSpacing: -2, fontWeight: FontWeight.w900)),
              const SizedBox(height: 14),
              const Text('Four languages. Endless good vibes.',
                style: TextStyle(color: Color(0xFFC4D5D2), height: 1.5)),
              const SizedBox(height: 22),
              Wrap(spacing: 12, runSpacing: 10, children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: green,
                    foregroundColor: const Color(0xFF10241B), elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                  onPressed: list.isEmpty ? null : () => play(list.first),
                  icon: const Icon(Icons.play_arrow, size: 20),
                  label: const Text('Explore the mix',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                TextButton.icon(onPressed: () => open(playlistUrl),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Spotify playlist')),
              ]),
            ])),
          if (!compact) ...[
            const SizedBox(width: 24),
            Transform.rotate(angle: .10,
              child: Cover(list.isEmpty ? songs.first : list.first,
                size: 174, radius: 18)),
          ],
        ]),
      );
    });
  Widget _actions(List<Song> list) => Row(children: [
        GestureDetector(
          onTap: () {
            if (current != null && list.contains(current)) {
              togglePlay();
            } else if (list.isNotEmpty) {
              play(list.first);
            }
          },
          child: Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(color: green, shape: BoxShape.circle),
            child: Icon(
                playing && current != null && list.contains(current)
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.black,
                size: 32),
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          iconSize: 30,
          tooltip: 'Shuffle',
          icon: Icon(Icons.shuffle, color: shuffle ? green : Colors.white60),
          onPressed: () => setState(() => shuffle = !shuffle),
        ),
        IconButton(
          iconSize: 28,
          tooltip: 'Open original playlist on Spotify',
          icon: const Icon(Icons.open_in_new, color: Colors.white60),
          onPressed: () => open(playlistUrl),
        ),
      ]);
  Widget _tableHeader(bool wide) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(children: [
          const SizedBox(
              width: 36,
              child: Text('#', style: TextStyle(color: Colors.white54))),
          const Expanded(
              child: Text('Title', style: TextStyle(color: Colors.white54))),
          if (wide)
            const SizedBox(
                width: 120,
                child: Text('Language',
                    style: TextStyle(color: Colors.white54))),
          const SizedBox(width: 40),
          const SizedBox(
              width: 48,
              child: Icon(Icons.access_time, size: 18, color: Colors.white54)),
        ]),
      );
  // ---------------- Players ----------------
  Widget _controls() => Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            tooltip: 'Shuffle',
            icon: Icon(Icons.shuffle, color: shuffle ? green : Colors.white60),
            onPressed: () => setState(() => shuffle = !shuffle)),
        IconButton(
            iconSize: 30,
            icon: const Icon(Icons.skip_previous),
            onPressed: () => step(-1)),
        GestureDetector(
          onTap: togglePlay,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration:
                const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(playing ? Icons.pause : Icons.play_arrow,
                color: Colors.black, size: 26),
          ),
        ),
        IconButton(
            iconSize: 30,
            icon: const Icon(Icons.skip_next),
            onPressed: () => step(1)),
        IconButton(
            tooltip: 'Repeat',
            icon: Icon(Icons.repeat, color: repeat ? green : Colors.white60),
            onPressed: () => setState(() => repeat = !repeat)),
      ]);
  Widget _progress() {
    final s = current;
    final total = s?.secs ?? 1;
    return Row(children: [
      SizedBox(
          width: 40,
          child: Text(fmt(elapsed),
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 11, color: Colors.white60))),
      Expanded(
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white24,
            thumbColor: Colors.white,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            value: elapsed.clamp(0, total).toDouble(),
            max: total.toDouble(),
            onChanged:
                s == null ? null : (v) => setState(() => elapsed = v.toInt()),
          ),
        ),
      ),
      SizedBox(
          width: 40,
          child: Text(s == null ? '0:00' : fmt(total),
              style: const TextStyle(fontSize: 11, color: Colors.white60))),
    ]);
  }
  Widget _desktopPlayer() {
    final s = current;
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.black,
      child: Row(children: [
        Expanded(
          flex: 3,
          child: s == null
              ? const Text('Select a song to start listening',
                  style: TextStyle(color: Colors.white54))
              : Row(children: [
                  Cover(s, size: 58),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(s.artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white60)),
                        ]),
                  ),
                  IconButton(
                    icon: Icon(
                        favs.contains(s) ? Icons.favorite : Icons.favorite_border,
                        color: favs.contains(s) ? green : Colors.white60),
                    onPressed: () => toggleFav(s),
                  ),
                ]),
        ),
        Expanded(
          flex: 4,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _controls(),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: _progress()),
          ]),
        ),
        Expanded(
          flex: 3,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            if (s != null)
              IconButton(
                  tooltip: 'Open in Spotify',
                  icon: const Icon(Icons.open_in_new, color: Colors.white60),
                  onPressed: () => open(s.searchUrl)),
            Icon(volume == 0 ? Icons.volume_off : Icons.volume_up,
                color: Colors.white60),
            SizedBox(
              width: 110,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white24,
                  thumbColor: Colors.white,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 5),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                    value: volume,
                    onChanged: (v) => setState(() => volume = v)),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
  Widget _mobilePlayer() {
    final s = current!;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(10, 8, 6, 4),
      decoration: BoxDecoration(
          color: Color.lerp(s.color, Colors.black, 0.35),
          borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          Cover(s, size: 46),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(s.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.white70)),
            ]),
          ),
          IconButton(tooltip: 'Open song on Spotify',
              icon: const Icon(Icons.open_in_new, size: 20),
              onPressed: () => open(s.searchUrl)),
          IconButton(
              iconSize: 34,
              icon: Icon(playing ? Icons.pause_circle : Icons.play_circle),
              onPressed: togglePlay),
          IconButton(icon: const Icon(Icons.skip_next), onPressed: () => step(1)),
        ]),
        Padding(
          padding: const EdgeInsets.only(right: 6, bottom: 4),
          child: LinearProgressIndicator(
            value: elapsed / s.secs,
            minHeight: 3,
            color: Colors.white,
            backgroundColor: Colors.white24,
          ),
        ),
      ]),
    );
  }
}
class SongRow extends StatefulWidget {
  final int index;
  final Song song;
  final bool isCurrent, playing, liked, wide;
  final String duration;
  final VoidCallback onTap, onLike;
  const SongRow({
    super.key,
    required this.index,
    required this.song,
    required this.isCurrent,
    required this.playing,
    required this.liked,
    required this.wide,
    required this.duration,
    required this.onTap,
    required this.onLike,
  });
  @override
  State<SongRow> createState() => _SongRowState();
}
class _SongRowState extends State<SongRow> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final s = widget.song;
    final cur = widget.isCurrent;
    Widget lead;
    if (cur && widget.playing) {
      lead = const Icon(Icons.equalizer, color: green, size: 20);
    } else if (hover) {
      lead = const Icon(Icons.play_arrow, size: 22);
    } else {
      lead = Text('${widget.index + 1}',
          style: TextStyle(color: cur ? green : Colors.white60, fontSize: 15));
    }
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: cur ? const Color(0xFF1E3934) : hover ? Colors.white10 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            SizedBox(width: 36, child: Center(child: lead)),
            Expanded(
              child: Row(children: [
                Cover(s, size: 42, radius: 4),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: cur ? green : Colors.white)),
                        Text(s.artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white60)),
                      ]),
                ),
              ]),
            ),
            if (widget.wide)
              SizedBox(
                  width: 120,
                  child: Text(s.lang,
                      style: const TextStyle(color: Colors.white60))),
            SizedBox(
              width: 40,
              child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                      icon: Icon(
                          widget.liked ? Icons.favorite : Icons.favorite_border,
                          color: widget.liked ? green : Colors.white60),
                      onPressed: widget.onLike),
            ),
            SizedBox(
                width: 48,
                child: Text(widget.duration,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.white60))),
          ]),
        ),
      ),
    );
  }
}

