import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

const isoDate = z
  .string()
  .regex(/^\d{4}-\d{2}-\d{2}$/, "Must be YYYY-MM-DD")
  .openapi({ example: "2026-05-26" });

export const mealSlot = z.enum(["sarapan", "siang", "malam", "cemilan"]);

export const weekQuerySchema = z.object({
  weekStart: isoDate.optional(),
});

export const mealPlanEntryInput = z.object({
  dayIndex: z.number().int().min(0).max(6).openapi({ example: 0 }),
  mealSlot: mealSlot.openapi({ example: "siang" }),
  recipeId: z.string().min(1).openapi({ example: "ayam-kecap-01" }),
});

export const putMealPlanSchema = z.object({
  weekStart: isoDate.optional(),
  entries: z.array(mealPlanEntryInput),
});

export const mealPlanEntryDto = z.object({
  dayIndex: z.number().int(),
  mealSlot: mealSlot,
  recipeId: z.string(),
});

export const mealPlanDto = z.object({
  weekStart: z.string().openapi({ example: "2026-05-26" }),
  updatedAt: z.string().openapi({ description: "ISO 8601 timestamp" }),
  entries: z.array(mealPlanEntryDto),
});

export type PutMealPlanInput = z.infer<typeof putMealPlanSchema>;
export type MealPlanEntryInput = z.infer<typeof mealPlanEntryInput>;
export type MealPlanEntryDto = z.infer<typeof mealPlanEntryDto>;
export type MealPlanDto = z.infer<typeof mealPlanDto>;
