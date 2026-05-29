import { Router } from "express";
import { authRouter } from "./modules/auth/auth.routes.js";
import { budgetRouter } from "./modules/budget/budget.routes.js";
import { favoritesRouter } from "./modules/favorites/favorites.routes.js";
import { pantryRouter } from "./modules/pantry/pantry.routes.js";
import { mealPlanRouter } from "./modules/meal-plan/meal-plan.routes.js";
import { groceryRouter } from "./modules/grocery/grocery.routes.js";
import { requireAuth } from "./middleware/auth.js";

export const apiRouter = Router();

apiRouter.use("/auth", authRouter);
apiRouter.use("/budget", requireAuth, budgetRouter);
apiRouter.use("/favorites", requireAuth, favoritesRouter);
apiRouter.use("/pantry", requireAuth, pantryRouter);
apiRouter.use("/meal-plan", requireAuth, mealPlanRouter);
apiRouter.use("/grocery", requireAuth, groceryRouter);
