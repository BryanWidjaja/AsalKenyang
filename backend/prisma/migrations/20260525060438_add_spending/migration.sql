-- CreateEnum
CREATE TYPE "SpendingKind" AS ENUM ('cook', 'manual');

-- CreateTable
CREATE TABLE "SpendingEntry" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "kind" "SpendingKind" NOT NULL,
    "recipeId" TEXT,
    "note" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SpendingEntry_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "SpendingEntry_userId_createdAt_idx" ON "SpendingEntry"("userId", "createdAt");

-- AddForeignKey
ALTER TABLE "SpendingEntry" ADD CONSTRAINT "SpendingEntry_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
