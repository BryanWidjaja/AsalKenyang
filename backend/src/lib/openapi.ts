import {
  OpenAPIRegistry,
  OpenApiGeneratorV3,
} from "@asteasolutions/zod-to-openapi";
import { authResponse, loginSchema, registerSchema } from "../schemas/auth.js";
import {
  budgetDto,
  monthQuerySchema,
  putBudgetSchema,
} from "../schemas/budget.js";
import {
  createSpendingSchema,
  spendingEntryDto,
  spendingListDto,
  spendingQuerySchema,
} from "../schemas/spending.js";
import {
  createFavoriteSchema,
  favoriteDto,
  favoriteParamsSchema,
  favoritesListDto,
} from "../schemas/favorites.js";
import { pantryDto, putPantrySchema } from "../schemas/pantry.js";
import {
  mealPlanDto,
  putMealPlanSchema,
  weekQuerySchema,
} from "../schemas/meal-plan.js";
import {
  groceryListDto,
  groceryQuerySchema,
  putGroceryCheckSchema,
} from "../schemas/grocery.js";

export const registry = new OpenAPIRegistry();

registry.registerComponent("securitySchemes", "bearerAuth", {
  type: "http",
  scheme: "bearer",
  bearerFormat: "JWT",
});

registry.registerPath({
  method: "post",
  path: "/api/v1/auth/register",
  tags: ["auth"],
  summary: "Register a new account",
  request: {
    body: { content: { "application/json": { schema: registerSchema } } },
  },
  responses: {
    201: {
      description: "Account created",
      content: { "application/json": { schema: authResponse } },
    },
    409: { description: "Email already registered" },
  },
});

registry.registerPath({
  method: "post",
  path: "/api/v1/auth/login",
  tags: ["auth"],
  summary: "Log in with email + password",
  request: {
    body: { content: { "application/json": { schema: loginSchema } } },
  },
  responses: {
    200: {
      description: "Authenticated",
      content: { "application/json": { schema: authResponse } },
    },
    401: { description: "Invalid credentials" },
  },
});

registry.registerPath({
  method: "get",
  path: "/api/v1/budget",
  tags: ["budget"],
  summary: "Get the user's budget for a month (default: current UTC month)",
  security: [{ bearerAuth: [] }],
  request: { query: monthQuerySchema },
  responses: {
    200: {
      description: "Budget for the month (null if not set)",
      content: { "application/json": { schema: budgetDto.nullable() } },
    },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "put",
  path: "/api/v1/budget",
  tags: ["budget"],
  summary: "Set/update the budget for a month",
  security: [{ bearerAuth: [] }],
  request: {
    body: { content: { "application/json": { schema: putBudgetSchema } } },
  },
  responses: {
    200: {
      description: "Budget upserted",
      content: { "application/json": { schema: budgetDto } },
    },
    400: { description: "Validation error" },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "get",
  path: "/api/v1/budget/spending",
  tags: ["budget"],
  summary: "List spending entries for a month (default: current UTC month)",
  security: [{ bearerAuth: [] }],
  request: { query: spendingQuerySchema },
  responses: {
    200: {
      description: "Spending list + month total",
      content: { "application/json": { schema: spendingListDto } },
    },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "post",
  path: "/api/v1/budget/spending",
  tags: ["budget"],
  summary: "Record a spending entry (cook or manual)",
  security: [{ bearerAuth: [] }],
  request: {
    body: { content: { "application/json": { schema: createSpendingSchema } } },
  },
  responses: {
    201: {
      description: "Spending entry created",
      content: { "application/json": { schema: spendingEntryDto } },
    },
    400: { description: "Validation error" },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "get",
  path: "/api/v1/favorites",
  tags: ["favorites"],
  summary: "List the user's favorite recipes",
  security: [{ bearerAuth: [] }],
  responses: {
    200: {
      description: "Favorite recipe references",
      content: { "application/json": { schema: favoritesListDto } },
    },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "post",
  path: "/api/v1/favorites",
  tags: ["favorites"],
  summary: "Favorite a recipe (idempotent)",
  security: [{ bearerAuth: [] }],
  request: {
    body: { content: { "application/json": { schema: createFavoriteSchema } } },
  },
  responses: {
    201: {
      description: "Favorited",
      content: { "application/json": { schema: favoriteDto } },
    },
    400: { description: "Validation error" },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "delete",
  path: "/api/v1/favorites/{recipeId}",
  tags: ["favorites"],
  summary: "Unfavorite a recipe (idempotent)",
  security: [{ bearerAuth: [] }],
  request: { params: favoriteParamsSchema },
  responses: {
    204: { description: "Removed" },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "get",
  path: "/api/v1/pantry",
  tags: ["pantry"],
  summary: "Get the user's pantry (selected ingredient keys)",
  security: [{ bearerAuth: [] }],
  responses: {
    200: {
      description: "Pantry (items empty + updatedAt null if never set)",
      content: { "application/json": { schema: pantryDto } },
    },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "put",
  path: "/api/v1/pantry",
  tags: ["pantry"],
  summary: "Replace the user's pantry with the given ingredient keys",
  security: [{ bearerAuth: [] }],
  request: {
    body: { content: { "application/json": { schema: putPantrySchema } } },
  },
  responses: {
    200: {
      description: "Pantry replaced",
      content: { "application/json": { schema: pantryDto } },
    },
    400: { description: "Validation error" },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "get",
  path: "/api/v1/meal-plan",
  tags: ["meal-plan"],
  summary: "Get the user's meal plan for a week (default: current week)",
  security: [{ bearerAuth: [] }],
  request: { query: weekQuerySchema },
  responses: {
    200: {
      description: "Meal plan for the week (null if not set)",
      content: { "application/json": { schema: mealPlanDto.nullable() } },
    },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "put",
  path: "/api/v1/meal-plan",
  tags: ["meal-plan"],
  summary: "Replace the meal plan for a week",
  security: [{ bearerAuth: [] }],
  request: {
    body: { content: { "application/json": { schema: putMealPlanSchema } } },
  },
  responses: {
    200: {
      description: "Meal plan replaced",
      content: { "application/json": { schema: mealPlanDto } },
    },
    400: { description: "Validation error" },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "get",
  path: "/api/v1/grocery",
  tags: ["grocery"],
  summary: "Get the grocery list derived from the week's meal plan",
  security: [{ bearerAuth: [] }],
  request: { query: groceryQuerySchema },
  responses: {
    200: {
      description: "Aggregated recipe list for the week",
      content: { "application/json": { schema: groceryListDto } },
    },
    401: { description: "Unauthorized" },
  },
});

registry.registerPath({
  method: "put",
  path: "/api/v1/grocery",
  tags: ["grocery"],
  summary: "Persist a local grocery checklist toggle",
  security: [{ bearerAuth: [] }],
  request: {
    body: {
      content: { "application/json": { schema: putGroceryCheckSchema } },
    },
  },
  responses: {
    200: {
      description: "Checklist state accepted",
      content: { "application/json": { schema: putGroceryCheckSchema } },
    },
    400: { description: "Validation error" },
    401: { description: "Unauthorized" },
  },
});

export function buildOpenApiDocument() {
  const generator = new OpenApiGeneratorV3(registry.definitions);
  return generator.generateDocument({
    openapi: "3.0.0",
    info: { title: "AsalKenyang API", version: "1.0.0" },
    servers: [{ url: "/" }],
  });
}
