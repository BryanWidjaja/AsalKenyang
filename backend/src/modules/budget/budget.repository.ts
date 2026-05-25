import { prisma } from "../../lib/prisma.js";

export const budgetRepository = {
  find(userId: string, month: string) {
    return prisma.budget.findUnique({
      where: { userId_month: { userId, month } },
    });
  },
  upsert(userId: string, month: string, amount: number) {
    return prisma.budget.upsert({
      where: { userId_month: { userId, month } },
      create: { userId, month, amount },
      update: { amount },
    });
  },
};
