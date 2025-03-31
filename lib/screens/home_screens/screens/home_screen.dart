// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class StreamfiHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (!isMobile) _buildSideNavigation(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(isMobile),
                  SliverToBoxAdapter(
                    child: _buildFeaturedStream(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildLiveStreamSection(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildTrendingSection(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isMobile ? _buildBottomNav() : null,
    );
  }

  Widget _buildAppBar(bool isMobile) {
    return SliverAppBar(
      floating: true,
      title: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          Image.asset(
            'assets/streamfi_logo.png',
            height: 30,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.graphic_eq, color: Colors.purple[400]),
          ),
          SizedBox(width: 8),
          Text('Streamfi', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        if (!isMobile)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://placekitten.com/200/200',
            ),
            backgroundColor: Colors.purple[800],
            radius: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSideNavigation() {
    return Container(
      width: 240,
      color: Colors.black,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            selected: true,
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.trending_up),
            title: Text('Trending'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.watch_later),
            title: Text('Watch Later'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.live_tv),
            title: Text('Live'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Saved Videos'),
            onTap: () {},
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RECOMMENDED', style: TextStyle(color: Colors.grey)),
                TextButton(
                  child: Text('See more'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          _buildChannelListTile('Zyn', '220K watching'),
          _buildChannelListTile('monki', '122K watching'),
          _buildChannelListTile('Guraissay', 'Offline'),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('FOLLOWING', style: TextStyle(color: Colors.grey)),
                TextButton(
                  child: Text('See more'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          _buildChannelListTile('Zyn', '100K Followers'),
          _buildChannelListTile('monki', '80K Followers'),
          _buildChannelListTile('Guraissay', '520K Followers'),
        ],
      ),
    );
  }

  Widget _buildChannelListTile(String name, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://placekitten.com/100/100',
        ),
      ),
      title: Text(name),
      subtitle:
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
      onTap: () {},
    );
  }

  Widget _buildFeaturedStream() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://place-hold.it/1000x800/444/fff/000?text=Call%20of%20Duty&fontsize=20',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.purple[800]!,
                  width: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Live',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://place-hold.it/100x100/003/fff?text=Streamer'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Call of duty ; Modern',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Warfare LiveStream',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(Icons.volume_up),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(Icons.picture_in_picture),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                          ),
                          IconButton(
                            icon: Icon(Icons.fullscreen),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                          ),
                        ],
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
  }

  Widget _buildLiveStreamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live on Streamfi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                child: Row(
                  children: [
                    Text('See more'),
                    Icon(Icons.chevron_right),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildStreamThumbnail(
                  'Clash of clans Live play', 'Clash of Clans'),
              _buildStreamThumbnail('Clash of clans Live play', 'Valorant'),
              _buildStreamThumbnail('Clash of clans Live play', 'Fortnite'),
              _buildStreamThumbnail('Clash of clans Live play', 'Sports Game'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending in Gaming',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                child: Row(
                  children: [
                    Text('See more'),
                    Icon(Icons.chevron_right),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildStreamThumbnail('Clash of clans Live play', 'Medieval Game',
                  'assets/medieval.jpg'),
              _buildStreamThumbnail('Clash of clans Live play', 'Hunter Game',
                  'assets/hunter.jpg'),
              _buildStreamThumbnail('Clash of clans Live play',
                  'Female Streamer', 'assets/streamer1.jpg'),
              _buildStreamThumbnail('Clash of clans Live play', 'Male Streamer',
                  'assets/streamer2.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStreamThumbnail(String title, String game, [String? imagePath]) {
    return Container(
      width: 210,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imagePath != null
                      ? Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(
                            'https://place-hold.it/300x200/${(game.hashCode % 900 + 100).toString()}/fff?text=$game',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.network(
                          'https://place-hold.it/300x200/${(game.hashCode % 900 + 100).toString()}/fff?text=$game',
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Live',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.visibility, size: 14, color: Colors.white),
                        SizedBox(width: 2),
                        Text(
                          '14.5k',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.blue[700],
                child: Text(
                  'F',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Flaxgames',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          // Tags
          Row(
            children: [
              _buildTag('Nigerian'),
              SizedBox(width: 6),
              _buildTag('Gameplay'),
              SizedBox(width: 6),
              _buildTag('Gameplay'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
          label: 'Subscriptions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: 'Library',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black,
      currentIndex: 0,
    );
  }
}
