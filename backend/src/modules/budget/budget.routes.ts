import { Router } from "express";
import { spendingRouter } from "../spending/spending.routes.js";
import { getBudget, putBudget } from "./budget.controller.js";

export const budgetRouter = Router();

budgetRouter.use("/spending", spendingRouter);
budgetRouter.get("/", getBudget);
budgetRouter.put("/", putBudget);
