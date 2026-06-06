import { budgetRepository } from "./budget.repository.js";
import type { BudgetDto, PutBudgetInput } from "../../schemas/budget.js";

function currentMonth(): string {
  const now = new Date();
  const year = now.getUTCFullYear();
  const month = String(now.getUTCMonth() + 1).padStart(2, "0");

  return `${year}-${month}`;
}

function toDto(budget: {
  month: string;
  amount: number;
  updatedAt: Date;
}): BudgetDto {
  return {
    month: budget.month,
    amount: budget.amount,
    updatedAt: budget.updatedAt.toISOString(),
  };
}

export const budgetService = {
  async get(
    userId: string,
    month: string | undefined,
  ): Promise<BudgetDto | null> {
    const resolvedMonth = month ?? currentMonth();
    const row = await budgetRepository.find(userId, resolvedMonth);

    return row ? toDto(row) : null;
  },

  async upsert(userId: string, input: PutBudgetInput): Promise<BudgetDto> {
    const resolvedMonth = input.month ?? currentMonth();
    const row = await budgetRepository.upsert(userId, resolvedMonth, input.amount);

    return toDto(row);
  },
};
