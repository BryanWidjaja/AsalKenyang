import { prisma } from "../../lib/prisma.js";

export const authRepository = {
  findByEmail(email: string) {
    return prisma.user.findUnique({ where: { email } });
  },
  createUser(email: string, passwordHash: string) {
    return prisma.user.create({ data: { email, passwordHash } });
  },
};
