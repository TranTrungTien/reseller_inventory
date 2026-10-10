# Architecture

## Layers
Each feature evolves into `domain/`, `data/`, `application/`, `presentation/`. Keep Flutter widgets out of domain/data. Repositories are the boundary between application logic and local/remote sources.

## Offline-first invariant
Every user mutation succeeds against local storage first. A durable inventory event/outbox is written in the same local transaction. Background sync pushes unsynced events. Network availability must never block core physical workflows.

## Conflict rules
- Scalar metadata: latest accepted server revision can merge when safe.
- Bin/location changes: never silently overwrite concurrent moves; surface conflict.
- Deletes/archives: tombstone, do not hard-delete during sync.
- Inventory events are immutable.

## Domain extensions
Workspace -> Location -> Bin -> Item. Item has marketplace references, photos and inventory events. Do not create platform-specific core item types.

## IDs
Client-generated UUID/ULID so entities can be created offline. QR payload should contain opaque bin identity only, not private inventory data.

## Security
Keep auth tokens in OS secure storage, signed remote requests, scoped workspace authorization, encrypted transport, least-privilege object access. Images live in object storage after sync but retain a local path/cache.
