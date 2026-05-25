import type { RequestHandler } from "express";
import { registerSchema, loginSchema } from "../../schemas/auth.js";
import { authService } from "./auth.service.js";

export const register: RequestHandler = async (req, res) => {
  const input = registerSchema.parse(req.body);
  res.status(201).json(await authService.register(input));
};

export const login: RequestHandler = async (req, res) => {
  const input = loginSchema.parse(req.body);
  res.status(200).json(await authService.login(input));
};
