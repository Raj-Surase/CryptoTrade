import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'crypto_trade.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // Future<String?> getCurrentLoggedInUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // Retrieve the username stored in shared preferences
  //   return prefs.getString('loggedInUsername');
  // }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create user table
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            username TEXT,
            mobile TEXT,
            password TEXT
          )
        ''');

        // Create payment history table
        await db.execute('''
          CREATE TABLE payments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            amount REAL,
            date TEXT,
            method TEXT,
            FOREIGN KEY (userId) REFERENCES users(id)
          )
        ''');

        // Create balance table
        await db.execute('''
          CREATE TABLE balance(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            balance REAL,
            FOREIGN KEY (userId) REFERENCES users(id)
          )
        ''');
      },
    );
  }

  Future<void> updateBalanceByPage(
      String destinationPage, int userId, double amount) async {
    final Database db = await database;
    double currentBalance = await getBalance(userId);
    double updatedBalance = currentBalance + amount;

    // Update the balance based on the destination page
    if (destinationPage == 'BuyCrypto' || destinationPage == 'SellCrypto') {
      // Subtract or add the amount based on the transaction type
      await db.rawUpdate(
        'UPDATE balance SET balance = ? WHERE userId = ?',
        [updatedBalance, userId],
      );
    }
  }

  Future<String> getPasswordHashByUsername(String username) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      columns: ['password'],
      where: 'username = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return maps.first['password'];
    } else {
      return ''; // You may choose to return null or handle this case differently
    }
  }

  Future<void> registerUser(
      String email, String username, String mobile, String password) async {
    final Database db = await database;
    await db.insert(
      'users',
      {
        'email': email,
        'username': username,
        'mobile': mobile,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Initialize balance for new user
    await db.insert(
      'balance',
      {
        'userId': await getUserIdByEmail(email),
        'balance': 500,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getUserIdByEmail(String email) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty ? maps.first['id'] : -1;
  }

  Future<int> getUserId(String username) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      columns: ['id'],
      where: 'username = ?',
      whereArgs: [username],
    );
    return maps.isNotEmpty ? maps.first['id'] : -1;
  }

  Future<void> updateBalance(int userId, double amount) async {
    final Database db = await database;
    double currentBalance = await getBalance(userId);
    double updatedBalance = currentBalance + amount;
    await db.rawUpdate(
      'UPDATE balance SET balance = ? WHERE userId = ?',
      [updatedBalance, userId],
    );
  }

  Future<double> getBalance(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'balance',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps.isNotEmpty ? maps.first['balance'] : 0.0;
  }

  Future<double> getBalanceByUsername(String username) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT b.balance
      FROM balance AS b
      INNER JOIN users AS u ON u.id = b.userId
      WHERE u.username = ?
    ''', [username]);
    return maps.isNotEmpty ? maps.first['balance'] : 0.0;
  }

  Future<void> insertPayment(int userId, double amount, String method) async {
    final Database db = await database;
    await db.insert(
      'payments',
      {
        'userId': userId,
        'amount': amount,
        'date':
            DateTime.now().toIso8601String(), // Store the current date and time
        'method': method,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getRecentTransactionsByUsername(
      String username) async {
    final Database db = await database;
    final List<Map<String, dynamic>> transactions = await db.query(
      'payments',
      where: 'userId = (SELECT id FROM users WHERE username = ?)',
      whereArgs: [username],
      orderBy: 'date DESC',
      limit: 10, // Limit the number of transactions to display
    );
    return transactions;
  }
}
