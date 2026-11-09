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

  Future<void> open(String url) =>
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  void dispose() {
    timer?.cancel();
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, c) {
          final wide = c.maxWidth >= 900;
          if (wide) {
            return Column(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Row(children: [
                    _sidebar(),
                    const SizedBox(width: 8),
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
        width: 280,
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
    final tint = current?.color ?? tints[filter]!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(wide ? 12 : 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [tint, bg],
            stops: const [0.0, 0.5],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(wide ? 24 : 16, 16, wide ? 24 : 16, 24),
          children: [
            _topBar(wide),
            if (!wide) _chips(),
            const SizedBox(height: 16),
            _hero(wide, list),
            const SizedBox(height: 16),
            _actions(list),
            const SizedBox(height: 8),
            _tableHeader(wide),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 8),
            if (list.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                    child: Text('No songs found',
                        style: TextStyle(color: Colors.white54, fontSize: 16))),
              ),
            for (int i = 0; i < list.length; i++)
              SongRow(
                index: i,
                song: list[i],
                isCurrent: list[i] == current,
                playing: playing,
                liked: favs.contains(list[i]),
                wide: wide,
                duration: fmt(list[i].secs),
                onTap: () => play(list[i]),
                onLike: () => toggleFav(list[i]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _topBar(bool wide) => Row(children: [
        if (!wide) ...const [
          Icon(Icons.graphic_eq, color: green, size: 28),
          SizedBox(width: 6),
          Text('TuneWave',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          SizedBox(width: 12),
        ],
        Expanded(
          child: Align(
            alignment: wide ? Alignment.centerLeft : Alignment.centerRight,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: SizedBox(
                height: 44,
                child: TextField(
                  focusNode: searchFocus,
                  onChanged: (v) => setState(() => query = v),
                  decoration: InputDecoration(
                    hintText: 'What do you want to play?',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFF242424),
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);

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

  Widget _hero(bool wide, List<Song> list) {
    final coverSong = list.isNotEmpty ? list.first : songs.first;
    final cover = Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black54, blurRadius: 30, offset: Offset(0, 10))
      ]),
      child: Cover(coverSong, size: wide ? 210 : 150, radius: 8),
    );
    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('PLAYLIST',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(playlistNames[filter]!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: wide ? 56 : 30,
                fontWeight: FontWeight.w900,
                height: 1.05,
                letterSpacing: -1)),
        const SizedBox(height: 10),
        Text('Top trending songs in Hindi, English, Telugu & Tamil',
            style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
          const Icon(Icons.graphic_eq, color: green, size: 18),
          const SizedBox(width: 4),
          Text('TuneWave · ${list.length} songs',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
      ],
    );
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      cover,
      SizedBox(width: wide ? 24 : 14),
      Expanded(child: info),
    ]);
  }

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
          IconButton(
              icon: Icon(favs.contains(s) ? Icons.favorite : Icons.favorite_border,
                  color: favs.contains(s) ? green : Colors.white),
              onPressed: () => toggleFav(s)),
          IconButton(
              icon: const Icon(Icons.skip_previous), onPressed: () => step(-1)),
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: hover ? Colors.white10 : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
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
              child: (widget.liked || hover)
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                      icon: Icon(
                          widget.liked ? Icons.favorite : Icons.favorite_border,
                          color: widget.liked ? green : Colors.white60),
                      onPressed: widget.onLike)
                  : null,
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
