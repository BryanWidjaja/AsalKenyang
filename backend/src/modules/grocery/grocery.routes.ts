import { Router } from "express";
import { getGrocery, putGroceryCheck } from "./grocery.controller.js";

export const groceryRouter = Router();

groceryRouter.get("/", getGrocery);
groceryRouter.put("/", putGroceryCheck);
