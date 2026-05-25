import { afterAll, describe, expect, it } from "vitest";
import request from "supertest";
import { createApp } from "../src/app.js";
import { prisma } from "../src/lib/prisma.js";

const app = createApp();
const password = "rahasia123";
const email = `vitest_${Date.now()}@binus.ac.id`;

afterAll(async () => {
  await prisma.user.deleteMany({
    where: { email: { startsWith: "vitest_" } },
  });
  await prisma.$disconnect();
});

describe("POST /api/v1/auth/register", () => {
  it("creates an account and returns token + user", async () => {
    const res = await request(app)
      .post("/api/v1/auth/register")
      .send({ email, password });
    expect(res.status).toBe(201);
    expect(typeof res.body.token).toBe("string");
    expect(res.body.user.email).toBe(email.toLowerCase());
    expect(typeof res.body.user.id).toBe("string");
    expect(typeof res.body.user.createdAt).toBe("string");
  });

  it("rejects duplicate email with 409", async () => {
    const res = await request(app)
      .post("/api/v1/auth/register")
      .send({ email, password });
    expect(res.status).toBe(409);
  });

  it("rejects invalid email format with 400", async () => {
    const res = await request(app)
      .post("/api/v1/auth/register")
      .send({ email: "not-an-email", password });
    expect(res.status).toBe(400);
  });

  it("rejects short password with 400", async () => {
    const res = await request(app)
      .post("/api/v1/auth/register")
      .send({
        email: `vitest_short_${Date.now()}@binus.ac.id`,
        password: "short",
      });
    expect(res.status).toBe(400);
  });
});

describe("POST /api/v1/auth/login", () => {
  it("returns 200 with a token for valid credentials", async () => {
    const res = await request(app)
      .post("/api/v1/auth/login")
      .send({ email, password });
    expect(res.status).toBe(200);
    expect(typeof res.body.token).toBe("string");
  });

  it("is case-insensitive on email (uppercased email logs in)", async () => {
    const res = await request(app)
      .post("/api/v1/auth/login")
      .send({ email: email.toUpperCase(), password });
    expect(res.status).toBe(200);
  });

  it("rejects wrong password with 401", async () => {
    const res = await request(app)
      .post("/api/v1/auth/login")
      .send({ email, password: "wrong-password" });
    expect(res.status).toBe(401);
  });

  it("rejects unknown email with 401", async () => {
    const res = await request(app)
      .post("/api/v1/auth/login")
      .send({
        email: `vitest_nope_${Date.now()}@binus.ac.id`,
        password,
      });
    expect(res.status).toBe(401);
  });
});
