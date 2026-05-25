import { Router } from "express";
import { createSpending, listSpending } from "./spending.controller.js";

export const spendingRouter = Router();

spendingRouter.get("/", listSpending);
spendingRouter.post("/", createSpending);
