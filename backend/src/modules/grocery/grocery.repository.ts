import { prisma } from "../../lib/prisma.js";

export const groceryRepository = {
  findEntries(userId: string, weekStart: string) {
    return prisma.mealPlan.findUnique({
      where: { userId_weekStart: { userId, weekStart } },
      include: { entries: { select: { recipeId: true } } },
    });
  },
};
