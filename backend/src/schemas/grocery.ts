import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

const isoDate = z
  .string()
  .regex(/^\d{4}-\d{2}-\d{2}$/, "Must be YYYY-MM-DD")
  .openapi({ example: "2026-05-26" });

export const groceryQuerySchema = z.object({
  weekStart: isoDate.optional(),
});

export const groceryItemDto = z.object({
  recipeId: z.string(),
  count: z.number().int().openapi({ description: "Times this recipe appears in the week" }),
});

export const groceryListDto = z.object({
  weekStart: z.string().openapi({ example: "2026-05-26" }),
  items: z.array(groceryItemDto),
});

export const putGroceryCheckSchema = z.object({
  bahanKey: z.string().min(1).openapi({ example: "telur" }),
  isChecked: z.boolean().openapi({ example: true }),
});

export type GroceryItemDto = z.infer<typeof groceryItemDto>;
export type GroceryListDto = z.infer<typeof groceryListDto>;
export type PutGroceryCheckInput = z.infer<typeof putGroceryCheckSchema>;
