import { afterAll, beforeAll, describe, expect, it } from "vitest";
import request from "supertest";
import { createApp } from "../src/app.js";
import { prisma } from "../src/lib/prisma.js";

const app = createApp();
const password = "rahasia123";
const email = `vitest_budget_${Date.now()}@binus.ac.id`;
let token: string;

beforeAll(async () => {
  const res = await request(app)
    .post("/api/v1/auth/register")
    .send({ email, password });
  token = res.body.token;
});

afterAll(async () => {
  await prisma.budget.deleteMany({
    where: { user: { email: { startsWith: "vitest_budget_" } } },
  });
  await prisma.user.deleteMany({
    where: { email: { startsWith: "vitest_budget_" } },
  });
  await prisma.$disconnect();
});

describe("/api/v1/budget (guarded)", () => {
  it("returns 401 without a Bearer token", async () => {
    const res = await request(app).get("/api/v1/budget");
    expect(res.status).toBe(401);
  });

  it("GET returns null when no budget is set", async () => {
    const res = await request(app)
      .get("/api/v1/budget")
      .set("Authorization", `Bearer ${token}`);
    expect(res.status).toBe(200);
    expect(res.body).toBeNull();
  });

  it("PUT sets the current month's budget", async () => {
    const res = await request(app)
      .put("/api/v1/budget")
      .set("Authorization", `Bearer ${token}`)
      .send({ amount: 500000 });
    expect(res.status).toBe(200);
    expect(res.body.amount).toBe(500000);
    expect(res.body.month).toMatch(/^\d{4}-(0[1-9]|1[0-2])$/);
  });

  it("GET returns the upserted budget", async () => {
    const res = await request(app)
      .get("/api/v1/budget")
      .set("Authorization", `Bearer ${token}`);
    expect(res.status).toBe(200);
    expect(res.body.amount).toBe(500000);
  });

  it("PUT updates an existing month", async () => {
    const res = await request(app)
      .put("/api/v1/budget")
      .set("Authorization", `Bearer ${token}`)
      .send({ amount: 750000 });
    expect(res.status).toBe(200);
    expect(res.body.amount).toBe(750000);
  });

  it("PUT supports an explicit month", async () => {
    const res = await request(app)
      .put("/api/v1/budget")
      .set("Authorization", `Bearer ${token}`)
      .send({ month: "2030-12", amount: 100000 });
    expect(res.status).toBe(200);
    expect(res.body.month).toBe("2030-12");
    expect(res.body.amount).toBe(100000);
  });

  it("GET ?month= returns that specific month", async () => {
    const res = await request(app)
      .get("/api/v1/budget?month=2030-12")
      .set("Authorization", `Bearer ${token}`);
    expect(res.status).toBe(200);
    expect(res.body.month).toBe("2030-12");
    expect(res.body.amount).toBe(100000);
  });

  it("rejects negative amount with 400", async () => {
    const res = await request(app)
      .put("/api/v1/budget")
      .set("Authorization", `Bearer ${token}`)
      .send({ amount: -1 });
    expect(res.status).toBe(400);
  });

  it("rejects invalid month format with 400", async () => {
    const res = await request(app)
      .put("/api/v1/budget")
      .set("Authorization", `Bearer ${token}`)
      .send({ month: "2030-13", amount: 100 });
    expect(res.status).toBe(400);
  });
});
