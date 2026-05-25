import { Router } from "express";
import { authRouter } from "./modules/auth/auth.routes.js";
import { budgetRouter } from "./modules/budget/budget.routes.js";
import { requireAuth } from "./middleware/auth.js";

export const apiRouter = Router();

apiRouter.use("/auth", authRouter);
apiRouter.use("/budget", requireAuth, budgetRouter);
