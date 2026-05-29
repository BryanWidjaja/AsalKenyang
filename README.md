# AsalKenyang

AsalKenyang is a Flutter app for Indonesian boarding-house students who want to cook from available ingredients, keep meals within budget, plan weekly menus, and track grocery needs.

The project includes a local-first Flutter frontend and an Express/TypeScript backend for authenticated sync.

## Features

- Recipe matching from saved ingredients
- Recipe detail pages with ingredients, estimated price, calories, and cooking steps
- Monthly budget tracking and spending history
- Weekly meal planning
- Grocery list aggregation from planned meals
- Saved ingredients with editable quantities
- Favorite recipes
- Authenticated backend sync for user data

## Tech Stack

Frontend:

- Flutter / Dart
- Riverpod
- Drift SQLite
- Dio
- Freezed and json_serializable
- flutter_secure_storage

Backend:

- Node.js / Express / TypeScript
- Prisma
- PostgreSQL
- JWT authentication
- Zod validation
- OpenAPI / Swagger UI
- Vitest and Supertest

## Project Structure

```text
.
+-- backend/      Express API, Prisma schema, tests, Docker setup
+-- frontend/     Flutter app
+-- tools/        Supporting scripts and data tooling
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

Run the backend:

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

On Windows PowerShell, use `npm.cmd` if script execution policy blocks `npm`:

```bash
npm.cmd run build
npm.cmd test
```

## Frontend Setup

From `frontend/`:

```bash
flutter pub get
flutter run --dart-define-from-file=config/dev.json
```

The default dev config is:

```json
{
  "API_URL": "http://10.0.2.2:3000"
}
```

Use `10.0.2.2` for Android emulator access to a backend running on the host machine. For Chrome or desktop targets, use `http://localhost:3000`. For a physical phone, use the host machine's LAN IP.

Frontend checks:

```bash
flutter analyze
flutter test
dart run build_runner build --delete-conflicting-outputs
```

## API Routes

All feature routes are under `/api/v1`.

Public routes:

- `POST /auth/register`
- `POST /auth/login`

Protected routes:

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

## Recipe Data

Bundled recipes live in:

```text
frontend/assets/data/recipes.json
```

Each recipe includes basic metadata, estimated price, estimated calories, ingredients, ingredient prices, cooking steps, tags, and image URL.

## Development Notes

- The frontend is local-first and writes user actions to local storage before syncing.
- The backend stores per-user budget, spending, pantry, meal-plan, grocery, and favorite data.
- Generated Dart files should be refreshed after model changes with `build_runner`.
