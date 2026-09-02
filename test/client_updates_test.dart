import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sole_ledger/data/db/database.dart';
import 'package:sole_ledger/data/providers.dart';
import 'package:sole_ledger/data/repositories/app_repository.dart';

/// Editing a client has to reach every screen already showing it. The detail
/// and invoice screens read one client by id, and when that read was a one-shot
/// Future they kept rendering the name the client had when the screen opened.
void main() {
  late AppDatabase db;
  late AppRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = AppRepository(db);
  });
  tearDown(() => db.close());

  Future<void> seed(String id, String name) => repo.upsertClient(
        ClientsCompanion(id: Value(id), name: Value(name)),
      );

  test('watchClient emits again when the client is edited', () async {
    await seed('c1', 'Acme B.V.');

    final seen = <String?>[];
    final sub = repo.watchClient('c1').listen((c) => seen.add(c?.name));
    await Future<void>.delayed(Duration.zero);

    await repo.upsertClient(const ClientsCompanion(
      id: Value('c1'),
      name: Value('Acme Nederland B.V.'),
    ));
    await Future<void>.delayed(Duration.zero);

    expect(seen, ['Acme B.V.', 'Acme Nederland B.V.']);
    await sub.cancel();
  });

  test('an edit updates the row in place rather than adding one', () async {
    await seed('c1', 'Acme B.V.');
    await repo.upsertClient(const ClientsCompanion(
      id: Value('c1'),
      name: Value('Renamed B.V.'),
      city: Value('Rotterdam'),
    ));

    final all = await repo.watchClients().first;
    expect(all, hasLength(1));
    expect(all.single.id, 'c1');
    expect(all.single.name, 'Renamed B.V.');
    expect(all.single.city, 'Rotterdam');
  });

  test('an invoice follows its client through a rename', () async {
    await seed('c1', 'Acme B.V.');
    await repo.createInvoice(
      invoice: InvoicesCompanion.insert(
        id: 'i1',
        number: 'INV-2026-0001',
        clientId: 'c1',
        issueDate: DateTime(2026, 9, 1),
        dueDate: DateTime(2026, 10, 1),
        createdAt: DateTime(2026, 9, 1),
      ),
      lines: const [],
      timeEntryIds: const [],
    );

    final names = <String?>[];
    final invoice = await repo.findInvoice('i1');
    final sub =
        repo.watchClient(invoice!.clientId).listen((c) => names.add(c?.name));
    await Future<void>.delayed(Duration.zero);

    await repo.upsertClient(const ClientsCompanion(
      id: Value('c1'),
      name: Value('Acme Nederland B.V.'),
    ));
    await Future<void>.delayed(Duration.zero);

    // The invoice keeps pointing at the same client, and the name it renders
    // is the current one.
    expect(names.last, 'Acme Nederland B.V.');
    expect((await repo.findInvoice('i1'))!.clientId, 'c1');
    await sub.cancel();
  });

  test('watching an unknown client yields null rather than throwing', () async {
    expect(await repo.watchClient('nope').first, isNull);
  });

  // The bug itself lived in the provider, not the repository: clientProvider
  // was a one-shot FutureProvider, so the screens reading through it never saw
  // an edit. Assert through the provider so swapping it back would fail here.
  test('clientProvider re-emits after the client is edited', () async {
    await seed('c1', 'Acme B.V.');
    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);

    final seen = <String?>[];
    container.listen(
      clientProvider('c1'),
      (_, next) => seen.add(next.value?.name),
      fireImmediately: true,
    );
    await container.read(clientProvider('c1').future);

    await repo.upsertClient(const ClientsCompanion(
      id: Value('c1'),
      name: Value('Acme Nederland B.V.'),
    ));
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(seen.last, 'Acme Nederland B.V.',
        reason: 'clientProvider must watch the row, not read it once');
  });
}
