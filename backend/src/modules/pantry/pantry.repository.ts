import { prisma } from "../../lib/prisma.js";

export const pantryRepository = {
  find(userId: string) {
    return prisma.pantryItem.findMany({ where: { userId } });
  },
  async upsert(userId: string, items: { bahanKey: string; quantity: string | null }[]) {
    return prisma.$transaction(async (transaction) => {
      await transaction.pantryItem.deleteMany({ where: { userId } });

      if (items.length > 0) {
        await transaction.pantryItem.createMany({
          data: items.map((item) => ({
            userId,
            bahanKey: item.bahanKey,
            quantity: item.quantity,
          })),
        });
      }

      return transaction.pantryItem.findMany({ where: { userId } });
    });
  },
};
