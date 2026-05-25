import type { RequestHandler } from "express";
import { monthQuerySchema, putBudgetSchema } from "../../schemas/budget.js";
import { budgetService } from "./budget.service.js";

export const getBudget: RequestHandler = async (req, res) => {
  const { month } = monthQuerySchema.parse(req.query);
  const result = await budgetService.get(req.userId!, month);
  res.status(200).json(result);
};

export const putBudget: RequestHandler = async (req, res) => {
  const input = putBudgetSchema.parse(req.body);
  const result = await budgetService.upsert(req.userId!, input);
  res.status(200).json(result);
};
