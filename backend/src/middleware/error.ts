import type { ErrorRequestHandler } from "express";
import { ZodError } from "zod";
import { AppError } from "../lib/errors.js";

export const errorHandler: ErrorRequestHandler = (err, _req, res, _next) => {
  if (err instanceof ZodError) {
    res.status(400).json({
      error: "VALIDATION_ERROR",
      message: "Invalid request payload",
      details: err.flatten().fieldErrors,
    });
    return;
  }
  if (err instanceof AppError) {
    res.status(err.statusCode).json({ error: err.code, message: err.message });
    return;
  }
  console.error("Unhandled error:", err);
  res.status(500).json({ error: "INTERNAL", message: "Internal server error" });
};
