import 'package:flutter/material.dart';

class mood_track extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoodTrackerHomePage(),
    );
  }
}

class MoodTrackerHomePage extends StatefulWidget {
  @override
  _MoodTrackerHomePageState createState() => _MoodTrackerHomePageState();
}

class _MoodTrackerHomePageState extends State<MoodTrackerHomePage> {
  List<MoodEntry> _moodEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _moodEntries.length,
              itemBuilder: (context, index) {
                final moodEntry = _moodEntries[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MoodEntryDetailPage(moodEntry: moodEntry),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(moodEntry.mood),
                    subtitle: Text(
                      '${moodEntry.date.year}-${moodEntry.date.month}-${moodEntry.date.day}',
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _addMoodEntry(context);
              },
              child: Text('Add Mood Entry'),
            ),
          ),
        ],
      ),
    );
  }

  void _addMoodEntry(BuildContext context) async {
    final today = DateTime.now();
    if (_moodEntries.isEmpty || _moodEntries.last.date.day != today.day) {
      String selectedMood = MoodEntry.moodOptions.first;
      String journalEntry = '';

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Mood Entry'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Your Mood:'),
                DropdownButton<String>(
                  value: selectedMood,
                  onChanged: (value) {
                    setState(() {
                      selectedMood = value!;
                    });
                  },
                  items: MoodEntry.moodOptions
                      .map((mood) => DropdownMenuItem<String>(
                            value: mood,
                            child: Text(mood),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Journal Your Thoughts',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    journalEntry = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (selectedMood != null) {
                    setState(() {
                      _moodEntries.add(
                        MoodEntry(
                            mood: selectedMood,
                            date: today,
                            journalEntry: journalEntry),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Entry'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Entry already exists'),
            content: Text('You have already made an entry for today.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class MoodEntry {
  final String mood;
  final DateTime date;
  final String journalEntry; // Added property for journal entry

  MoodEntry(
      {required this.mood, required this.date, required this.journalEntry});

  static List<String> moodOptions = [
    'Happy',
    'Sad',
    'Stressed',
    'Anxious',
    // Add more mood options as needed
  ];
}

class MoodEntryDetailPage extends StatelessWidget {
  final MoodEntry moodEntry;

  MoodEntryDetailPage({required this.moodEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Entry Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final updatedMoodEntry = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMoodEntryPage(moodEntry: moodEntry),
                ),
              );
              if (updatedMoodEntry != null) {
                // Update moodEntry if result is not null
                // You may want to update your UI here or handle other logic
                // For now, let's just print the updated moodEntry
                print('Updated Mood Entry: $updatedMoodEntry');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mood: ${moodEntry.mood}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${moodEntry.date.year}-${moodEntry.date.month}-${moodEntry.date.day}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Journal Entry:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              moodEntry.journalEntry,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class EditMoodEntryPage extends StatefulWidget {
  final MoodEntry moodEntry;

  EditMoodEntryPage({required this.moodEntry});

  @override
  _EditMoodEntryPageState createState() => _EditMoodEntryPageState();
}

class _EditMoodEntryPageState extends State<EditMoodEntryPage> {
  late String selectedMood;
  late String journalEntry;

  @override
  void initState() {
    super.initState();
    selectedMood = widget.moodEntry.mood;
    journalEntry = widget.moodEntry.journalEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Mood Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Mood:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedMood,
              onChanged: (value) {
                setState(() {
                  selectedMood = value!;
                });
              },
              items: MoodEntry.moodOptions
                  .map((mood) => DropdownMenuItem<String>(
                        value: mood,
                        child: Text(mood),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Edit Your Journal Entry',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  journalEntry = value;
                });
              },
              controller: TextEditingController(text: journalEntry),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update moodEntry and pop the screen with result
          final updatedMoodEntry = MoodEntry(
            mood: selectedMood,
            date: widget.moodEntry.date,
            journalEntry: journalEntry,
          );
          Navigator.pop(context, updatedMoodEntry);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
