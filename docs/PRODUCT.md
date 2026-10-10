# Product Specification

## Positioning
The fastest physical inventory companion for one-of-one resellers. The app owns physical truth; marketplaces own listings.

## ICP
Solo/small-team eBay, Poshmark, Depop, Mercari, Etsy, Vinted, Grailed and Whatnot resellers with roughly 100-5,000 unique items.

## Core jobs
1. Intake a thrift haul with near-zero typing.
2. Find a sold item immediately.
3. Move items/bins in bulk.
4. Inspect/audit a bin.
5. Never lose the inventory database.

## Core flows
### Onboarding
Storage type -> inventory size -> create A01 -> label/QR -> add first item -> search it.
### Turbo Intake
Scan bin -> persistent camera -> capture item -> local save -> haptic/beep -> repeat. Metadata enrichment is deferred.
### Find
Search title/SKU/attributes/bin -> result emphasizes physical location -> Found It.
### Pick
Sold items -> sort by physical route -> scan expected bin -> found -> picked/sold.
### Move
Scan source -> select all/subset -> scan destination -> commit locally -> undo toast -> enqueue sync event.
### Audit
Scan bin -> expected set -> verify -> missing list -> retain location history.

## Status
DRAFT -> STORED -> LISTED -> SOLD -> PICKED -> ARCHIVED; branches RETURNED, MISSING, DONATED, DISPOSED.

## P0
Account/workspace, location/bin, QR, item/photos/SKU/cost, turbo intake, offline search, move, sold, local DB, backup/sync boundary, CSV import/export.

## P1
Pick list, audit, inventory history, bulk actions, label printing, multi-device, cost allocation, Needs Attention, duplicate SKU detection.

## Non-goals for MVP
Crosslisting, shipping labels, CRM, tax filing, full bookkeeping, AI chatbot, marketplace messaging, pricing intelligence.

## Global rules
Never hardcode $, lb, inch, MM/DD/YYYY or tax assumptions. Store ISO currency, canonical units, UTC timestamps plus locale-aware formatting. Support Letter and A4 label layouts. Tax exports are organizational records only.
