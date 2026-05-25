import { afterAll, beforeAll, describe, expect, it } from "vitest";
import request from "supertest";
import { createApp } from "../src/app.js";
import { prisma } from "../src/lib/prisma.js";

const app = createApp();
const password = "rahasia123";
const email = `vitest_pantry_${Date.now()}@binus.ac.id`;
let token: string;

beforeAll(async () => {
  const res = await request(app)
    .post("/api/v1/auth/register")
    .send({ email, password });
  token = res.body.token;
});

afterAll(async () => {
  await prisma.pantry.deleteMany({
    where: { user: { email: { startsWith: "vitest_pantry_" } } },
  });
  await prisma.user.deleteMany({
    where: { email: { startsWith: "vitest_pantry_" } },
  });
  await prisma.$disconnect();
});

const auth = () => ({ Authorization: `Bearer ${token}` });

describe("/api/v1/pantry (guarded)", () => {
  it("returns 401 without a token", async () => {
    const res = await request(app).get("/api/v1/pantry");
    expect(res.status).toBe(401);
  });

  it("returns empty items and null updatedAt when never set", async () => {
    const res = await request(app).get("/api/v1/pantry").set(auth());
    expect(res.status).toBe(200);
    expect(res.body.items).toEqual([]);
    expect(res.body.updatedAt).toBeNull();
  });

  it("PUT sets the pantry items", async () => {
    const res = await request(app)
      .put("/api/v1/pantry")
      .set(auth())
      .send({ items: ["ayam", "telur", "cabai"] });
    expect(res.status).toBe(200);
    expect(res.body.items).toEqual(["ayam", "telur", "cabai"]);
    expect(typeof res.body.updatedAt).toBe("string");
  });

  it("GET returns the saved items", async () => {
    const res = await request(app).get("/api/v1/pantry").set(auth());
    expect(res.status).toBe(200);
    expect(res.body.items).toEqual(["ayam", "telur", "cabai"]);
  });

  it("PUT replaces (not merges) and de-duplicates", async () => {
    const res = await request(app)
      .put("/api/v1/pantry")
      .set(auth())
      .send({ items: ["tahu", "tahu", "tempe"] });
    expect(res.status).toBe(200);
    expect(res.body.items).toEqual(["tahu", "tempe"]);
  });

  it("rejects a non-array items with 400", async () => {
    const res = await request(app)
      .put("/api/v1/pantry")
      .set(auth())
      .send({ items: "ayam" });
    expect(res.status).toBe(400);
  });
});
