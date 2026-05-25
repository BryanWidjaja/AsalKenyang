import { afterAll, beforeAll, describe, expect, it } from "vitest";
import request from "supertest";
import { createApp } from "../src/app.js";
import { prisma } from "../src/lib/prisma.js";

const app = createApp();
const password = "rahasia123";
const email = `vitest_fav_${Date.now()}@binus.ac.id`;
let token: string;

beforeAll(async () => {
  const res = await request(app)
    .post("/api/v1/auth/register")
    .send({ email, password });
  token = res.body.token;
});

afterAll(async () => {
  await prisma.favorite.deleteMany({
    where: { user: { email: { startsWith: "vitest_fav_" } } },
  });
  await prisma.user.deleteMany({
    where: { email: { startsWith: "vitest_fav_" } },
  });
  await prisma.$disconnect();
});

const auth = () => ({ Authorization: `Bearer ${token}` });

describe("/api/v1/favorites (guarded)", () => {
  it("returns 401 without a token", async () => {
    const res = await request(app).get("/api/v1/favorites");
    expect(res.status).toBe(401);
  });

  it("starts empty", async () => {
    const res = await request(app).get("/api/v1/favorites").set(auth());
    expect(res.status).toBe(200);
    expect(res.body).toEqual([]);
  });

  it("adds a favorite", async () => {
    const res = await request(app)
      .post("/api/v1/favorites")
      .set(auth())
      .send({ recipeId: "ayam-kecap-01" });
    expect(res.status).toBe(201);
    expect(res.body.recipeId).toBe("ayam-kecap-01");
  });

  it("is idempotent (adding the same recipe twice keeps one)", async () => {
    await request(app)
      .post("/api/v1/favorites")
      .set(auth())
      .send({ recipeId: "ayam-kecap-01" });
    const res = await request(app).get("/api/v1/favorites").set(auth());
    expect(res.status).toBe(200);
    expect(res.body.length).toBe(1);
  });

  it("rejects an empty recipeId with 400", async () => {
    const res = await request(app)
      .post("/api/v1/favorites")
      .set(auth())
      .send({ recipeId: "" });
    expect(res.status).toBe(400);
  });

  it("removes a favorite (204)", async () => {
    const res = await request(app)
      .delete("/api/v1/favorites/ayam-kecap-01")
      .set(auth());
    expect(res.status).toBe(204);
    const list = await request(app).get("/api/v1/favorites").set(auth());
    expect(list.body).toEqual([]);
  });

  it("delete is idempotent (removing a missing favorite still 204)", async () => {
    const res = await request(app)
      .delete("/api/v1/favorites/nonexistent-recipe")
      .set(auth());
    expect(res.status).toBe(204);
  });
});
