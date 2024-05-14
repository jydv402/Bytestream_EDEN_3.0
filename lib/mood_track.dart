import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodTrackerHomePage extends StatefulWidget {
  const MoodTrackerHomePage({super.key});

  @override
  _MoodTrackerHomePageState createState() => _MoodTrackerHomePageState();
}

class _MoodTrackerHomePageState extends State<MoodTrackerHomePage> {
  List<MoodEntry> _moodEntries = [];

  @override
  void initState() {
    super.initState();
    _loadMoodEntries();
  }

  void _loadMoodEntries() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? entriesJson = prefs.getStringList('mood_entries');
    if (entriesJson != null) {
      setState(() {
        _moodEntries = entriesJson.map((entryJson) {
          return MoodEntry.fromJson(entryJson);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mood Tracker",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _moodEntries.length,
              itemBuilder: (context, index) {
                final moodEntry = _moodEntries[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MoodEntryDetailPage(moodEntry: moodEntry),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.green[100]),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListTile(
                          title: Text(
                            moodEntry.mood,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${moodEntry.date.day} - ${moodEntry.date.month} - ${moodEntry.date.year}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade100)),
              onPressed: () {
                _addMoodEntry(context);
              },
              child: const Text(
                'Add Mood Entry',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addMoodEntry(BuildContext context) async {
    final today = DateTime.now();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if an entry already exists for today
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
                onPressed: () async {
                  if (selectedMood != null) {
                    final newEntry = MoodEntry(
                      mood: selectedMood,
                      date: today,
                      journalEntry: journalEntry,
                    );
                    setState(() {
                      _moodEntries.add(newEntry);
                    });
                    prefs.setStringList(
                      'mood_entries',
                      _moodEntries.map((entry) => entry.toJson()).toList(),
                    );
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

  MoodEntry({
    required this.mood,
    required this.date,
    required this.journalEntry,
  });

  static List<String> moodOptions = [
    'Happy',
    'Sad',
    'Stressed',
    'Anxious',
    // Add more mood options as needed
  ];

  MoodEntry.fromJson(String json)
      : mood = json.split(',')[0],
        date = DateTime.parse(json.split(',')[1]),
        journalEntry = json.split(',')[2];

  String toJson() => '$mood,${date.toString()},$journalEntry';
}

class MoodEntryDetailPage extends StatelessWidget {
  final MoodEntry moodEntry;

  MoodEntryDetailPage({required this.moodEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Mood Entry Detail',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
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
            const SizedBox(height: 50),
            Text(
              'Mood: ${moodEntry.mood}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${moodEntry.date.day} - ${moodEntry.date.month} - ${moodEntry.date.year}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
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
        centerTitle: true,
        title: const Text(
          'Edit Mood Entry',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
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
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.green.shade100,
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
