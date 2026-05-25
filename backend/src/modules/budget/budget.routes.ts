import { Router } from "express";
import { getBudget, putBudget } from "./budget.controller.js";

export const budgetRouter = Router();

budgetRouter.get("/", getBudget);
budgetRouter.put("/", putBudget);
