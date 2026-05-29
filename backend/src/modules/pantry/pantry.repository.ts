import { prisma } from "../../lib/prisma.js";

export const pantryRepository = {
  find(userId: string) {
    return prisma.pantryItem.findMany({ where: { userId } });
  },
  async upsert(userId: string, items: { bahanKey: string; quantity: string | null }[]) {
    return prisma.$transaction(async (tx) => {
      await tx.pantryItem.deleteMany({ where: { userId } });
      if (items.length > 0) {
        await tx.pantryItem.createMany({
          data: items.map((i) => ({
            userId,
            bahanKey: i.bahanKey,
            quantity: i.quantity,
          })),
        });
      }
      return tx.pantryItem.findMany({ where: { userId } });
    });
  },
};
