import { afterAll, beforeAll, describe, expect, it } from "vitest";
import request from "supertest";
import { createApp } from "../src/app.js";
import { prisma } from "../src/lib/prisma.js";

const app = createApp();
const password = "rahasia123";
const email = `vitest_spending_${Date.now()}@binus.ac.id`;
let token: string;

beforeAll(async () => {
  const res = await request(app)
    .post("/api/v1/auth/register")
    .send({ email, password });
  token = res.body.token;
});

afterAll(async () => {
  await prisma.spendingEntry.deleteMany({
    where: { user: { email: { startsWith: "vitest_spending_" } } },
  });
  await prisma.user.deleteMany({
    where: { email: { startsWith: "vitest_spending_" } },
  });
  await prisma.$disconnect();
});

const auth = () => ({ Authorization: `Bearer ${token}` });

describe("/api/v1/budget/spending (guarded)", () => {
  it("returns 401 without a token", async () => {
    const res = await request(app).get("/api/v1/budget/spending");
    expect(res.status).toBe(401);
  });

  it("starts empty with total 0", async () => {
    const res = await request(app).get("/api/v1/budget/spending").set(auth());
    expect(res.status).toBe(200);
    expect(res.body.total).toBe(0);
    expect(res.body.entries).toEqual([]);
  });

  it("records a cook spending entry", async () => {
    const res = await request(app)
      .post("/api/v1/budget/spending")
      .set(auth())
      .send({ amount: 18000, kind: "cook", recipeId: "ayam-kecap-01" });
    expect(res.status).toBe(201);
    expect(res.body.amount).toBe(18000);
    expect(res.body.kind).toBe("cook");
    expect(res.body.recipeId).toBe("ayam-kecap-01");
  });

  it("records a manual spending entry", async () => {
    const res = await request(app)
      .post("/api/v1/budget/spending")
      .set(auth())
      .send({ amount: 12000, kind: "manual", note: "jajan" });
    expect(res.status).toBe(201);
    expect(res.body.kind).toBe("manual");
    expect(res.body.recipeId).toBeNull();
  });

  it("lists entries and sums the month total", async () => {
    const res = await request(app).get("/api/v1/budget/spending").set(auth());
    expect(res.status).toBe(200);
    expect(res.body.total).toBe(30000);
    expect(res.body.entries.length).toBe(2);
  });

  it("rejects an invalid kind with 400", async () => {
    const res = await request(app)
      .post("/api/v1/budget/spending")
      .set(auth())
      .send({ amount: 1000, kind: "gift" });
    expect(res.status).toBe(400);
  });

  it("rejects a non-positive amount with 400", async () => {
    const res = await request(app)
      .post("/api/v1/budget/spending")
      .set(auth())
      .send({ amount: 0, kind: "manual" });
    expect(res.status).toBe(400);
  });
});
