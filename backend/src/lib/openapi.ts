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

export function buildOpenApiDocument() {
  const generator = new OpenApiGeneratorV3(registry.definitions);
  return generator.generateDocument({
    openapi: "3.0.0",
    info: { title: "AsalKenyang API", version: "1.0.0" },
    servers: [{ url: "/" }],
  });
}
