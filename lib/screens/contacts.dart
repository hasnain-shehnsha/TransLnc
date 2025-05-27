import 'package:flutter/material.dart';


class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        primaryColor: Color(0xFF0A66C2),
        fontFamily: 'varsity_regular',
      ),
      home: ContactsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Contact {
  final String name;
  final String image;
  final bool hasApp;

  Contact(this.name, this.image, this.hasApp);
}

class ContactsPage extends StatelessWidget {
  final Color mainColor = Color(0xFF0A66C2);

  final Map<String, List<Contact>> groupedContacts = {
    'A': [
      Contact('Amy Richardson', 'assets/user1.png', true),
      Contact('Adam Wilson', 'assets/user2.png', true),
      Contact('Andrew Scott', 'assets/user3.png', false),
      Contact('Alex Turner', 'assets/user4.png', true),
    ],
    'B': [
      Contact('Brian Carter', 'assets/user5.png', false),
      Contact('Benjamin Taylor', 'assets/user6.png', true),
      Contact('Bella James', 'assets/user7.png', true),
      Contact('Bianca Torres', 'assets/user8.png', false),
    ],
  };

  ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios_new, color: mainColor),
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab bar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: Text('Office', style: TextStyle(color: Colors.grey)),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text(
                        'Personal',
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        height: 2,
                        width: 50,
                        color: mainColor,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: groupedContacts.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        entry.key,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...entry.value.map((contact) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(contact.image),
                        ),
                        title: Text(contact.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (contact.hasApp)
                              Icon(Icons.apps, color: mainColor),
                            SizedBox(width: 12),
                            Icon(Icons.phone_outlined, color: Colors.grey),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: mainColor,
        child: Icon(Icons.apps),
      ),
    );
  }
}
