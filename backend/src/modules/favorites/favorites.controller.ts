import type { RequestHandler } from "express";
import {
  createFavoriteSchema,
  favoriteParamsSchema,
} from "../../schemas/favorites.js";
import { favoritesService } from "./favorites.service.js";

export const listFavorites: RequestHandler = async (req, res) => {
  res.status(200).json(await favoritesService.list(req.userId!));
};

export const addFavorite: RequestHandler = async (req, res) => {
  const { recipeId } = createFavoriteSchema.parse(req.body);
  res.status(201).json(await favoritesService.add(req.userId!, recipeId));
};

export const removeFavorite: RequestHandler = async (req, res) => {
  const { recipeId } = favoriteParamsSchema.parse(req.params);
  await favoritesService.remove(req.userId!, recipeId);
  res.status(204).send();
};
