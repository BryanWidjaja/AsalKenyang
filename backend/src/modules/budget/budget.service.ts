import { budgetRepository } from "./budget.repository.js";
import type { BudgetDto, PutBudgetInput } from "../../schemas/budget.js";

function currentMonth(): string {
  const d = new Date();
  const y = d.getUTCFullYear();
  const m = String(d.getUTCMonth() + 1).padStart(2, "0");
  return `${y}-${m}`;
}

function toDto(b: {
  month: string;
  amount: number;
  updatedAt: Date;
}): BudgetDto {
  return {
    month: b.month,
    amount: b.amount,
    updatedAt: b.updatedAt.toISOString(),
  };
}

export const budgetService = {
  async get(
    userId: string,
    month: string | undefined,
  ): Promise<BudgetDto | null> {
    const m = month ?? currentMonth();
    const row = await budgetRepository.find(userId, m);
    return row ? toDto(row) : null;
  },
  async upsert(userId: string, input: PutBudgetInput): Promise<BudgetDto> {
    const m = input.month ?? currentMonth();
    const row = await budgetRepository.upsert(userId, m, input.amount);
    return toDto(row);
  },
};
