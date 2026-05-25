import type { RequestHandler } from "express";
import { verifyAccessToken } from "../lib/jwt.js";
import { unauthorized } from "../lib/errors.js";

export const requireAuth: RequestHandler = (req, _res, next) => {
  const header = req.headers.authorization;
  if (!header?.startsWith("Bearer ")) {
    throw unauthorized("Missing or malformed Authorization header");
  }
  try {
    req.userId = verifyAccessToken(header.slice("Bearer ".length));
  } catch {
    throw unauthorized("Invalid or expired token");
  }
  next();
};
