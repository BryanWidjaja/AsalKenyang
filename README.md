# AsalKenyang

AsalKenyang is an Android-first Flutter app for Indonesian boarding-house students (`anak kos`) who need to cook from leftover ingredients, limited cash, and simple kitchen tools. The product pitch from `.notes` is:

> Aplikasi dapur buat anak kos yang bantu kamu masak dari sisa bahan, sesuai isi dompet, pakai alat seadanya.

The app combines recipe matching, a living monthly food budget, weekly meal planning, a grocery checklist, favorites, and an authenticated backend for per-user sync.

## Current Status

This codebase is **not fully done yet**. It has a substantial frontend and backend scaffold, but it is not currently in a clean demo-ready state.

What is in place:

- Flutter frontend with auth screens, bottom-tab shell, Masak, Resep, Rencana, Belanja, Profil/Anggaran, Favorites, Detail, Spending History, and About screens.
- Local-first frontend architecture using Riverpod, Drift, Dio, secure token storage, local repositories, and an outbox-style sync engine.
- Bundled recipe loading from `frontend/assets/data/recipes.json`.
- Express/TypeScript backend with JWT auth, Prisma/PostgreSQL models, zod validation, OpenAPI/Swagger docs, and routes for auth, budget, spending, pantry, meal-plan, grocery, and favorites.
- Backend TypeScript build passes with `npm.cmd run build`.

Known gaps from the latest check:

- The frontend has a Dart syntax error in `frontend/lib/features/budget/data/budget_remote_source.dart` around the `recipeId` payload.
- `recipes.json` currently has 15 `mock_*` recipes, while `.notes` describes an MVP target of roughly 80-150 curated recipes.
- The backend grocery API is partial: it returns recipe counts from the weekly plan, and checklist updates are accepted but not persisted.
- Backend tests currently fail because Prisma cannot authenticate to the configured local Postgres database.
- Flutter verification was not completed in this environment because `flutter`/`dart` commands did not return.

## Tech Stack

Frontend:

- Flutter / Dart
- Riverpod for state and dependency injection
- Drift for local SQLite state
- Dio for API calls
- `flutter_secure_storage` for JWT storage
- Freezed and json_serializable for models

Backend:

- Node.js 24+ / Express 5 / TypeScript
- Prisma 7 with PostgreSQL
- JWT auth with bcrypt password hashing
- zod request validation
- OpenAPI docs with `@asteasolutions/zod-to-openapi` and Swagger UI
- Vitest + Supertest tests

## Repository Layout

```text
.
+-- backend/              Express API, Prisma schema, tests, Docker Compose
+-- frontend/             Flutter app
+-- .notes/               Product, feature, design, data, and tech notes
+-- tools/                Data-prep and supporting tooling notes/assets
+-- README.md
```

## Backend Setup

From `backend/`:

```bash
npm install
docker compose up -d db
```

Create `backend/.env`:

```env
DATABASE_URL="postgresql://asalkenyang:asalkenyang@localhost:5433/asalkenyang?schema=public"
JWT_SECRET="dev-only-change-me-but-make-it-long"
PORT=3000
CORS_ORIGINS="*"
```

Prepare Prisma and the database:

```bash
npm run prisma:generate
npx prisma db push
```

Run the API:

```bash
npm run dev
```

Useful backend URLs:

- Health check: `http://localhost:3000/health`
- Swagger UI: `http://localhost:3000/docs`
- OpenAPI JSON: `http://localhost:3000/openapi.json`

Backend checks:

```bash
npm run build
npm test
```

On Windows PowerShell, if `npm` is blocked by execution policy, use `npm.cmd`, for example:

```bash
npm.cmd run build
```

## Frontend Setup

From `frontend/`:

```bash
flutter pub get
flutter run --dart-define-from-file=config/dev.json
```

`frontend/config/dev.json` currently points to:

```json
{
  "API_URL": "http://10.0.2.2:3000"
}
```

Use `10.0.2.2` for an Android emulator talking to a backend on the host machine. For Chrome or a local desktop target, use `http://localhost:3000`. For a physical phone, use the host machine's LAN IP.

Useful frontend checks:

```bash
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
```

## API Surface

All feature routes are under `/api/v1`.

Public:

- `POST /auth/register`
- `POST /auth/login`

JWT-protected:

- `GET /budget`
- `PUT /budget`
- `GET /budget/spending`
- `POST /budget/spending`
- `GET /pantry`
- `PUT /pantry`
- `GET /meal-plan`
- `PUT /meal-plan`
- `GET /grocery`
- `PUT /grocery`
- `GET /favorites`
- `POST /favorites`
- `DELETE /favorites/:recipeId`

## MVP Completion Checklist

Based on `.notes/features.md`, `.notes/techstack.md`, and `.notes/todolist.md`, the project should only be treated as done when:

- The Flutter app builds, analyzes, and tests cleanly.
- The Dart syntax error in the budget remote source is fixed.
- Login/register work against the backend and offline local state still works without the backend.
- Budget, spending, pantry, meal-plan, grocery checklist, and favorites sync reliably through the backend.
- Grocery aggregation is ingredient-based, not just recipe-count-based.
- The bundled recipe catalog is expanded from the current 15 mock recipes toward the documented curated MVP dataset.
- Backend tests pass against a reproducible Postgres setup.
- The demo flow can run end-to-end: register/login, select pantry ingredients, find matching recipes, cook/spend budget, add to plan, generate grocery list, favorite recipes, and view spending history.

## Notes

The `.notes/` directory is the source of product intent:

- `.notes/idea.md` defines the app concept and pitch.
- `.notes/features.md` defines MVP screens, flows, and API surface.
- `.notes/techstack.md` defines architecture and stack decisions.
- `.notes/DESIGN.md` defines the visual system.
- `.notes/todolist.md` defines page-by-page frontend completion criteria.
- `.notes/gaps.md` says research gaps are closed, but implementation gaps still remain in the codebase.
