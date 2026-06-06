import { mealPlanRepository } from "./meal-plan.repository.js";
import type {
  MealPlanDto,
  MealPlanEntryDto,
  PutMealPlanInput,
} from "../../schemas/meal-plan.js";

function currentWeekStart(): string {
  const now = new Date();
  const day = now.getUTCDay();
  const diff = day === 0 ? -6 : 1 - day;
  const monday = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + diff));

  return monday.toISOString().slice(0, 10);
}

function toEntryDto(entry: {
  dayIndex: number;
  mealSlot: string;
  recipeId: string;
}): MealPlanEntryDto {
  return { dayIndex: entry.dayIndex, mealSlot: entry.mealSlot as MealPlanEntryDto["mealSlot"], recipeId: entry.recipeId };
}

function toDto(plan: {
  weekStart: string;
  updatedAt: Date;
  entries: { dayIndex: number; mealSlot: string; recipeId: string }[];
}): MealPlanDto {
  return {
    weekStart: plan.weekStart,
    updatedAt: plan.updatedAt.toISOString(),
    entries: plan.entries.map(toEntryDto),
  };
}

export const mealPlanService = {
  async get(userId: string, weekStart: string | undefined): Promise<MealPlanDto | null> {
    const resolvedWeekStart = weekStart ?? currentWeekStart();
    const row = await mealPlanRepository.find(userId, resolvedWeekStart);

    return row ? toDto(row) : null;
  },

  async replace(userId: string, input: PutMealPlanInput): Promise<MealPlanDto> {
    const resolvedWeekStart = input.weekStart ?? currentWeekStart();
    const row = await mealPlanRepository.upsert(userId, resolvedWeekStart, input.entries);

    return toDto(row);
  },
};
