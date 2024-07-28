// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'flight_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $FlightDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $FlightDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $FlightDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<FlightDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorFlightDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FlightDatabaseBuilderContract databaseBuilder(String name) =>
      _$FlightDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FlightDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$FlightDatabaseBuilder(null);
}

class _$FlightDatabaseBuilder implements $FlightDatabaseBuilderContract {
  _$FlightDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $FlightDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $FlightDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<FlightDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FlightDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlightDatabase extends FlightDatabase {
  _$FlightDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FlightDao? _flightDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Flight` (`flightId` TEXT NOT NULL, `departureCity` TEXT NOT NULL, `destinationCity` TEXT NOT NULL, `departureTime` TEXT NOT NULL, `arrivalTime` TEXT NOT NULL, PRIMARY KEY (`flightId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FlightDao get flightDao {
    return _flightDaoInstance ??= _$FlightDao(database, changeListener);
  }
}

class _$FlightDao extends FlightDao {
  _$FlightDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _flightInsertionAdapter = InsertionAdapter(
            database,
            'Flight',
            (Flight item) => <String, Object?>{
                  'flightId': item.flightId,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime
                },
            changeListener),
        _flightUpdateAdapter = UpdateAdapter(
            database,
            'Flight',
            ['flightId'],
            (Flight item) => <String, Object?>{
                  'flightId': item.flightId,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime
                },
            changeListener),
        _flightDeletionAdapter = DeletionAdapter(
            database,
            'Flight',
            ['flightId'],
            (Flight item) => <String, Object?>{
                  'flightId': item.flightId,
                  'departureCity': item.departureCity,
                  'destinationCity': item.destinationCity,
                  'departureTime': item.departureTime,
                  'arrivalTime': item.arrivalTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Flight> _flightInsertionAdapter;

  final UpdateAdapter<Flight> _flightUpdateAdapter;

  final DeletionAdapter<Flight> _flightDeletionAdapter;

  @override
  Future<List<Flight>> getAllFlight() async {
    return _queryAdapter.queryList('SELECT * FROM Flight',
        mapper: (Map<String, Object?> row) => Flight(
            row['flightId'] as String,
            row['departureCity'] as String,
            row['destinationCity'] as String,
            row['departureTime'] as String,
            row['arrivalTime'] as String));
  }

  @override
  Stream<Flight?> getFlightById(String flightId) {
    return _queryAdapter.queryStream('SELECT * FROM Flight WHERE flightId = ?1',
        mapper: (Map<String, Object?> row) => Flight(
            row['flightId'] as String,
            row['departureCity'] as String,
            row['destinationCity'] as String,
            row['departureTime'] as String,
            row['arrivalTime'] as String),
        arguments: [flightId],
        queryableName: 'Flight',
        isView: false);
  }

  @override
  Future<void> addFlight(Flight flight) async {
    await _flightInsertionAdapter.insert(flight, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateFlight(Flight flight) {
    return _flightUpdateAdapter.updateAndReturnChangedRows(
        flight, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFlight(Flight flight) {
    return _flightDeletionAdapter.deleteAndReturnChangedRows(flight);
  }
}
