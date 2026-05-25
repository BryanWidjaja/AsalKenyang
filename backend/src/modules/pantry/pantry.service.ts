import { pantryRepository } from "./pantry.repository.js";
import type { PantryDto, PutPantryInput } from "../../schemas/pantry.js";

function toDto(p: { bahanKeys: string[]; updatedAt: Date } | null): PantryDto {
  if (!p) return { items: [], updatedAt: null };
  return { items: p.bahanKeys, updatedAt: p.updatedAt.toISOString() };
}

export const pantryService = {
  async get(userId: string): Promise<PantryDto> {
    return toDto(await pantryRepository.find(userId));
  },
  async replace(userId: string, input: PutPantryInput): Promise<PantryDto> {
    const items = [
      ...new Set(input.items.map((i) => i.trim()).filter((i) => i.length > 0)),
    ];
    return toDto(await pantryRepository.upsert(userId, items));
  },
};
