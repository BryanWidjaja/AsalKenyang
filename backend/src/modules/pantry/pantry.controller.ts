import type { RequestHandler } from "express";
import { putPantrySchema } from "../../schemas/pantry.js";
import { pantryService } from "./pantry.service.js";

export const getPantry: RequestHandler = async (req, res) => {
  res.status(200).json(await pantryService.get(req.userId!));
};

export const putPantry: RequestHandler = async (req, res) => {
  const input = putPantrySchema.parse(req.body);
  res.status(200).json(await pantryService.replace(req.userId!, input));
};
