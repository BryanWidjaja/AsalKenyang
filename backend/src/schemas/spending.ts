import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

const monthString = z
  .string()
  .regex(/^\d{4}-(0[1-9]|1[0-2])$/, "Month must be YYYY-MM")
  .openapi({ example: "2026-05" });

export const spendingKind = z.enum(["cook", "manual"]);

export const spendingQuerySchema = z.object({
  month: monthString.optional(),
});

export const createSpendingSchema = z.object({
  amount: z.number().int().positive().openapi({ example: 18000 }),
  kind: spendingKind.openapi({ example: "cook" }),
  recipeId: z.string().optional().openapi({ example: "ayam-kecap-01" }),
  note: z.string().max(200).optional().openapi({ example: "Masak ayam kecap" }),
});

export const spendingEntryDto = z.object({
  id: z.string(),
  amount: z.number().int(),
  kind: spendingKind,
  recipeId: z.string().nullable(),
  note: z.string().nullable(),
  createdAt: z.string().openapi({ description: "ISO 8601 timestamp" }),
});

export const spendingListDto = z.object({
  month: z.string(),
  total: z.number().int(),
  entries: z.array(spendingEntryDto),
});

export type CreateSpendingInput = z.infer<typeof createSpendingSchema>;
export type SpendingKindType = z.infer<typeof spendingKind>;
export type SpendingEntryDto = z.infer<typeof spendingEntryDto>;
export type SpendingListDto = z.infer<typeof spendingListDto>;
