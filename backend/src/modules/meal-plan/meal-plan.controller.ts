import type { RequestHandler } from "express";
import { weekQuerySchema, putMealPlanSchema } from "../../schemas/meal-plan.js";
import { mealPlanService } from "./meal-plan.service.js";

export const getMealPlan: RequestHandler = async (req, res) => {
  const { weekStart } = weekQuerySchema.parse(req.query);
  res.status(200).json(await mealPlanService.get(req.userId!, weekStart));
};

export const putMealPlan: RequestHandler = async (req, res) => {
  const input = putMealPlanSchema.parse(req.body);
  res.status(200).json(await mealPlanService.replace(req.userId!, input));
};
