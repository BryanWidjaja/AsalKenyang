import { groceryRepository } from "./grocery.repository.js";
import type { GroceryItemDto, GroceryListDto } from "../../schemas/grocery.js";

function currentWeekStart(): string {
  const now = new Date();
  const day = now.getUTCDay();
  const diff = day === 0 ? -6 : 1 - day;
  const monday = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + diff));

  return monday.toISOString().slice(0, 10);
}

export const groceryService = {
  async get(userId: string, weekStart: string | undefined): Promise<GroceryListDto> {
    const resolvedWeekStart = weekStart ?? currentWeekStart();
    const plan = await groceryRepository.findEntries(userId, resolvedWeekStart);

    if (!plan) {
      return { weekStart: resolvedWeekStart, items: [] };
    }

    const counts = new Map<string, number>();
    for (const entry of plan.entries) {
      counts.set(entry.recipeId, (counts.get(entry.recipeId) ?? 0) + 1);
    }

    const items: GroceryItemDto[] = [...counts.entries()].map(
      ([recipeId, count]) => ({ recipeId, count }),
    );

    return { weekStart: resolvedWeekStart, items };
  },
};
