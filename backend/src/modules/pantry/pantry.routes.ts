import { Router } from "express";
import { getPantry, putPantry } from "./pantry.controller.js";

export const pantryRouter = Router();

pantryRouter.get("/", getPantry);
pantryRouter.put("/", putPantry);
