import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:domra_tech/model/word_translation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'domra_tech_cache.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cached_words(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        wordId INTEGER,
        englishWord TEXT,
        frenchWord TEXT,
        khmerWord TEXT,
        normalizedWord TEXT,
        definition TEXT,
        example TEXT,
        imageURL TEXT,
        reference TEXT,
        referenceText TEXT,
        cachedAt INTEGER
      )
    ''');
  }

  Future<void> cacheWords(List<WordTranslation> words) async {
    final db = await database;
    
    // Begin a transaction to ensure all or nothing is inserted cleanly
    await db.transaction((txn) async {
      // Clear old cached words first to store the newest API response
      await txn.delete('cached_words');

      final now = DateTime.now().millisecondsSinceEpoch;

      for (var word in words) {
        await txn.insert(
          'cached_words',
          {
            'wordId': word.wordId,
            'englishWord': word.englishWord,
            'frenchWord': word.frenchWord,
            'khmerWord': word.khmerWord,
            'normalizedWord': word.normalizedWord,
            'definition': word.definition,
            'example': word.example,
            'imageURL': word.imageURL,
            'reference': word.reference,
            'referenceText': word.referenceText,
            'cachedAt': now,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<WordTranslation>> getCachedWords() async {
    final db = await database;
    
    // Calculate timestamp for 24 hours ago
    final oneDayAgo = DateTime.now().subtract(const Duration(hours: 24)).millisecondsSinceEpoch;

    final List<Map<String, dynamic>> maps = await db.query(
      'cached_words',
      where: 'cachedAt > ?',
      whereArgs: [oneDayAgo],
    );

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return WordTranslation(
        wordId: maps[i]['wordId'],
        englishWord: maps[i]['englishWord'],
        frenchWord: maps[i]['frenchWord'],
        khmerWord: maps[i]['khmerWord'],
        normalizedWord: maps[i]['normalizedWord'],
        definition: maps[i]['definition'],
        example: maps[i]['example'],
        imageURL: maps[i]['imageURL'],
        reference: maps[i]['reference'],
        referenceText: maps[i]['referenceText'],
      );
    });
  }
}
