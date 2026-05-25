import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

export const registerSchema = z.object({
  email: z.string().trim().toLowerCase().email().openapi({ example: "anak.kos@binus.ac.id" }),
  password: z.string().min(8).openapi({ example: "rahasia123" }),
});

export const loginSchema = z.object({
  email: z.string().trim().toLowerCase().email().openapi({ example: "anak.kos@binus.ac.id" }),
  password: z.string().min(1).openapi({ example: "rahasia123" }),
});

export const userDto = z.object({
  id: z.string(),
  email: z.string().email(),
  createdAt: z.string().openapi({ description: "ISO 8601 timestamp" }),
});

export const authResponse = z.object({
  token: z.string(),
  user: userDto,
});

export type RegisterInput = z.infer<typeof registerSchema>;
export type LoginInput = z.infer<typeof loginSchema>;
export type AuthResponse = z.infer<typeof authResponse>;
