import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

export const putPantrySchema = z.object({
  items: z
    .array(
      z.object({
        bahanKey: z.string().min(1),
        quantity: z.string().nullable().optional(),
      })
    )
    .openapi({ example: [{ bahanKey: "ayam", quantity: "1" }] }),
});

export const pantryDto = z.object({
  items: z.array(
    z.object({
      bahanKey: z.string(),
      quantity: z.string().nullable(),
    })
  ),
});

export type PutPantryInput = z.infer<typeof putPantrySchema>;
export type PantryDto = z.infer<typeof pantryDto>;
