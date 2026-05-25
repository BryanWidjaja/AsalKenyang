import { prisma } from "../../lib/prisma.js";

export const favoritesRepository = {
  list(userId: string) {
    return prisma.favorite.findMany({
      where: { userId },
      orderBy: { createdAt: "desc" },
    });
  },
  add(userId: string, recipeId: string) {
    return prisma.favorite.upsert({
      where: { userId_recipeId: { userId, recipeId } },
      create: { userId, recipeId },
      update: {},
    });
  },
  remove(userId: string, recipeId: string) {
    return prisma.favorite.deleteMany({ where: { userId, recipeId } });
  },
};
