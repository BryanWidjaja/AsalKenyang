import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

const monthString = z
  .string()
  .regex(/^\d{4}-(0[1-9]|1[0-2])$/, "Month must be YYYY-MM")
  .openapi({ example: "2026-05" });

export const monthQuerySchema = z.object({
  month: monthString.optional(),
});

export const putBudgetSchema = z.object({
  month: monthString.optional(),
  amount: z.number().int().nonnegative().openapi({ example: 500000 }),
});

export const budgetDto = z.object({
  month: z.string().openapi({ example: "2026-05" }),
  amount: z.number().int().openapi({ example: 500000 }),
  updatedAt: z.string().openapi({ description: "ISO 8601 timestamp" }),
});

export type PutBudgetInput = z.infer<typeof putBudgetSchema>;
export type BudgetDto = z.infer<typeof budgetDto>;
