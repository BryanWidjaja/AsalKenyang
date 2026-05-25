import {
  OpenAPIRegistry,
  OpenApiGeneratorV3,
} from "@asteasolutions/zod-to-openapi";
import { registerSchema, loginSchema, authResponse } from "../schemas/auth.js";

export const registry = new OpenAPIRegistry();

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

export function buildOpenApiDocument() {
  const generator = new OpenApiGeneratorV3(registry.definitions);
  return generator.generateDocument({
    openapi: "3.0.0",
    info: { title: "AsalKenyang API", version: "1.0.0" },
    servers: [{ url: "/" }],
  });
}
