import { prisma } from "../../lib/prisma.js";
import type { SpendingKindType } from "../../schemas/spending.js";

interface CreateData {
  amount: number;
  kind: SpendingKindType;
  recipeId: string | null;
  note: string | null;
}

export const spendingRepository = {
  create(userId: string, data: CreateData) {
    return prisma.spendingEntry.create({ data: { userId, ...data } });
  },
  listByMonth(userId: string, start: Date, end: Date) {
    return prisma.spendingEntry.findMany({
      where: { userId, createdAt: { gte: start, lt: end } },
      orderBy: { createdAt: "desc" },
    });
  },
  totalByMonth(userId: string, start: Date, end: Date) {
    return prisma.spendingEntry.aggregate({
      where: { userId, createdAt: { gte: start, lt: end } },
      _sum: { amount: true },
    });
  },
};
