import { favoritesRepository } from "./favorites.repository.js";
import type { FavoriteDto } from "../../schemas/favorites.js";

function toDto(f: { recipeId: string; createdAt: Date }): FavoriteDto {
  return { recipeId: f.recipeId, createdAt: f.createdAt.toISOString() };
}

export const favoritesService = {
  async list(userId: string): Promise<FavoriteDto[]> {
    const rows = await favoritesRepository.list(userId);
    return rows.map(toDto);
  },
  async add(userId: string, recipeId: string): Promise<FavoriteDto> {
    const row = await favoritesRepository.add(userId, recipeId);
    return toDto(row);
  },
  async remove(userId: string, recipeId: string): Promise<void> {
    await favoritesRepository.remove(userId, recipeId);
  },
};
