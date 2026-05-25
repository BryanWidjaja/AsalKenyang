import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

export const putPantrySchema = z.object({
  items: z
    .array(z.string().min(1))
    .openapi({ example: ["ayam", "telur", "cabai"] }),
});

export const pantryDto = z.object({
  items: z.array(z.string()),
  updatedAt: z
    .string()
    .nullable()
    .openapi({ description: "ISO 8601 timestamp, null if never set" }),
});

export type PutPantryInput = z.infer<typeof putPantrySchema>;
export type PantryDto = z.infer<typeof pantryDto>;
