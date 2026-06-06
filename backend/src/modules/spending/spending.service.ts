import { spendingRepository } from "./spending.repository.js";
import type {
  CreateSpendingInput,
  SpendingEntryDto,
  SpendingKindType,
  SpendingListDto,
} from "../../schemas/spending.js";

function currentMonth(): string {
  const now = new Date();

  return `${now.getUTCFullYear()}-${String(now.getUTCMonth() + 1).padStart(2, "0")}`;
}

function monthRange(month: string): { start: Date; end: Date } {
  const year = Number(month.slice(0, 4));
  const monthIndex = Number(month.slice(5, 7)) - 1;
  return {
    start: new Date(Date.UTC(year, monthIndex, 1)),
    end: new Date(Date.UTC(year, monthIndex + 1, 1)),
  };
}

function toDto(entry: {
  id: string;
  amount: number;
  kind: SpendingKindType;
  recipeId: string | null;
  note: string | null;
  createdAt: Date;
}): SpendingEntryDto {
  return {
    id: entry.id,
    amount: entry.amount,
    kind: entry.kind,
    recipeId: entry.recipeId,
    note: entry.note,
    createdAt: entry.createdAt.toISOString(),
  };
}

export const spendingService = {
  async list(
    userId: string,
    month: string | undefined,
  ): Promise<SpendingListDto> {
    const resolvedMonth = month ?? currentMonth();
    const { start, end } = monthRange(resolvedMonth);
    const [entries, aggregate] = await Promise.all([
      spendingRepository.listByMonth(userId, start, end),
      spendingRepository.totalByMonth(userId, start, end),
    ]);

    return {
      month: resolvedMonth,
      total: aggregate._sum.amount ?? 0,
      entries: entries.map(toDto),
    };
  },

  async create(
    userId: string,
    input: CreateSpendingInput,
  ): Promise<SpendingEntryDto> {
    const entry = await spendingRepository.create(userId, {
      amount: input.amount,
      kind: input.kind,
      recipeId: input.recipeId ?? null,
      note: input.note ?? null,
    });

    return toDto(entry);
  },
};
