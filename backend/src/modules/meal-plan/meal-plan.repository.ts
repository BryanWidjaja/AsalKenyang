import { prisma } from "../../lib/prisma.js";

interface EntryData {
  dayIndex: number;
  mealSlot: string;
  recipeId: string;
}

export const mealPlanRepository = {
  find(userId: string, weekStart: string) {
    return prisma.mealPlan.findUnique({
      where: { userId_weekStart: { userId, weekStart } },
      include: { entries: true },
    });
  },
  async upsert(userId: string, weekStart: string, entries: EntryData[]) {
    return prisma.$transaction(async (tx) => {
      const existing = await tx.mealPlan.findUnique({
        where: { userId_weekStart: { userId, weekStart } },
      });

      if (existing) {
        await tx.mealPlanEntry.deleteMany({ where: { planId: existing.id } });
        return tx.mealPlan.update({
          where: { id: existing.id },
          data: {
            entries: { create: entries },
          },
          include: { entries: true },
        });
      }

      return tx.mealPlan.create({
        data: {
          userId,
          weekStart,
          entries: { create: entries },
        },
        include: { entries: true },
      });
    });
  },
};
