import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile1.png'),
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Hello\nArizona Alex',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.notifications_outlined),
                ],
              ),
              const SizedBox(height: 20),

              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Numbers & Names',
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Quick Access
              const Text(
                'Quick Access',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickAccessCard('Contact Bip'),
                  _quickAccessCard('Infobip Features'),
                ],
              ),
              const SizedBox(height: 20),

              // Recent
              const Text(
                'Recent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              // Recent List
              Expanded(
                child: ListView(
                  children: [
                    _recentCallTile(
                      name: "Lois Lane",
                      image: 'assets/profile2.png',
                      callType: "Incoming",
                      time: "11:30",
                      isIncoming: true,
                    ),
                    _recentCallTile(
                      name: "Edaward",
                      image: 'assets/profile3.png',
                      callType: "Outgoing",
                      time: "10:30",
                      isIncoming: false,
                    ),
                    _recentCallTile(
                      name: "Harry",
                      image: 'assets/profile4.png',
                      callType: "Outgoing",
                      time: "09:30",
                      isIncoming: false,
                    ),
                    _recentCallTile(
                      name: "Jagard",
                      image: 'assets/profile5.png',
                      callType: "Incoming",
                      time: "12:00",
                      isIncoming: true,
                    ),
                    _recentCallTile(
                      name: "Alex",
                      image: 'assets/profile6.png',
                      callType: "Outgoing",
                      time: "10:34",
                      isIncoming: false,
                    ),
                    _recentCallTile(
                      name: "Cristian",
                      image: 'assets/profile7.png',
                      callType: "Incoming",
                      time: "08:20",
                      isIncoming: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Quick Access Card
  Widget _quickAccessCard(String title) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F5FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.apps, color: Color(0xFF0A66C2)),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Call Tile
  Widget _recentCallTile({
    required String name,
    required String image,
    required String callType,
    required String time,
    required bool isIncoming,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        "$callType call $time",
        style: const TextStyle(fontSize: 12),
      ),
      trailing: const Icon(Icons.call_outlined),
    );
  }
}
