import { prisma } from "../../lib/prisma.js";

export const pantryRepository = {
  find(userId: string) {
    return prisma.pantry.findUnique({ where: { userId } });
  },
  upsert(userId: string, bahanKeys: string[]) {
    return prisma.pantry.upsert({
      where: { userId },
      create: { userId, bahanKeys },
      update: { bahanKeys },
    });
  },
};
