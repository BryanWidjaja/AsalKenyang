import express from "express";
import helmet from "helmet";
import cors from "cors";
import swaggerUi from "swagger-ui-express";
import { env } from "./lib/env.js";
import { apiRouter } from "./router.js";
import { errorHandler } from "./middleware/error.js";
import { buildOpenApiDocument } from "./lib/openapi.js";

export function createApp() {
  const app = express();

  app.use(helmet());
  app.use(cors({ origin: env.corsOrigins.includes("*") ? "*" : env.corsOrigins }));
  app.use(express.json());

  app.get("/health", (_req, res) => {
    res.json({ status: "ok" });
  });

  app.use("/api/v1", apiRouter);

  const openapiDoc = buildOpenApiDocument();
  app.get("/openapi.json", (_req, res) => {
    res.json(openapiDoc);
  });
  app.use("/docs", swaggerUi.serve, swaggerUi.setup(openapiDoc));

  app.use(errorHandler);

  return app;
}
