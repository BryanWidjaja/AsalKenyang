import type { RequestHandler } from "express";
import {
  createSpendingSchema,
  spendingQuerySchema,
} from "../../schemas/spending.js";
import { spendingService } from "./spending.service.js";

export const listSpending: RequestHandler = async (req, res) => {
  const { month } = spendingQuerySchema.parse(req.query);
  res.status(200).json(await spendingService.list(req.userId!, month));
};

export const createSpending: RequestHandler = async (req, res) => {
  const input = createSpendingSchema.parse(req.body);
  res.status(201).json(await spendingService.create(req.userId!, input));
};
