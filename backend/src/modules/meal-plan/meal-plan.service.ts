import { mealPlanRepository } from "./meal-plan.repository.js";
import type {
  MealPlanDto,
  MealPlanEntryDto,
  PutMealPlanInput,
} from "../../schemas/meal-plan.js";

function currentWeekStart(): string {
  const d = new Date();
  const day = d.getUTCDay();
  const diff = day === 0 ? -6 : 1 - day;
  const monday = new Date(Date.UTC(d.getUTCFullYear(), d.getUTCMonth(), d.getUTCDate() + diff));
  return monday.toISOString().slice(0, 10);
}

function toEntryDto(e: {
  dayIndex: number;
  mealSlot: string;
  recipeId: string;
}): MealPlanEntryDto {
  return { dayIndex: e.dayIndex, mealSlot: e.mealSlot as MealPlanEntryDto["mealSlot"], recipeId: e.recipeId };
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
    const ws = weekStart ?? currentWeekStart();
    const row = await mealPlanRepository.find(userId, ws);
    return row ? toDto(row) : null;
  },
  async replace(userId: string, input: PutMealPlanInput): Promise<MealPlanDto> {
    const ws = input.weekStart ?? currentWeekStart();
    const row = await mealPlanRepository.upsert(userId, ws, input.entries);
    return toDto(row);
  },
};
