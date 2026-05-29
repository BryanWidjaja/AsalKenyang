import type { RequestHandler } from "express";
import {
  groceryQuerySchema,
  putGroceryCheckSchema,
} from "../../schemas/grocery.js";
import { groceryService } from "./grocery.service.js";

export const getGrocery: RequestHandler = async (req, res) => {
  const { weekStart } = groceryQuerySchema.parse(req.query);
  res.status(200).json(await groceryService.get(req.userId!, weekStart));
};

export const putGroceryCheck: RequestHandler = async (req, res) => {
  const input = putGroceryCheckSchema.parse(req.body);
  res.status(200).json(input);
};
