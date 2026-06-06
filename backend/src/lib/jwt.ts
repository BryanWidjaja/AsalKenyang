import jwt, { type JwtPayload } from "jsonwebtoken";
import { env } from "./env.js";

const EXPIRES_IN = "7d";

export function signAccessToken(userId: string): string {
  return jwt.sign({ sub: userId }, env.JWT_SECRET, {
    algorithm: "HS256",
    expiresIn: EXPIRES_IN,
  });
}

export function verifyAccessToken(token: string): string {
  const payload = jwt.verify(token, env.JWT_SECRET) as JwtPayload;

  if (typeof payload.sub !== "string") {
    throw new Error("Token missing subject");
  }

  return payload.sub;
}
