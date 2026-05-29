import { Router } from "express";
import { getMealPlan, putMealPlan } from "./meal-plan.controller.js";

export const mealPlanRouter = Router();

mealPlanRouter.get("/", getMealPlan);
mealPlanRouter.put("/", putMealPlan);
