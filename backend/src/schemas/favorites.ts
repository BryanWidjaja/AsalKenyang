import { z } from "zod";
import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";

extendZodWithOpenApi(z);

export const createFavoriteSchema = z.object({
  recipeId: z.string().min(1).openapi({ example: "ayam-kecap-01" }),
});

export const favoriteParamsSchema = z.object({
  recipeId: z.string().min(1).openapi({ example: "ayam-kecap-01" }),
});

export const favoriteDto = z.object({
  recipeId: z.string(),
  createdAt: z.string().openapi({ description: "ISO 8601 timestamp" }),
});

export const favoritesListDto = z.array(favoriteDto);

export type CreateFavoriteInput = z.infer<typeof createFavoriteSchema>;
export type FavoriteDto = z.infer<typeof favoriteDto>;
