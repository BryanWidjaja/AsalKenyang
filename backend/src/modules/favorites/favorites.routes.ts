import { Router } from "express";
import {
  addFavorite,
  listFavorites,
  removeFavorite,
} from "./favorites.controller.js";

export const favoritesRouter = Router();

favoritesRouter.get("/", listFavorites);
favoritesRouter.post("/", addFavorite);
favoritesRouter.delete("/:recipeId", removeFavorite);
