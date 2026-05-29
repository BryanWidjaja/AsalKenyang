import { pantryRepository } from "./pantry.repository.js";
import type { PantryDto, PutPantryInput } from "../../schemas/pantry.js";

function toDto(items: any[]): PantryDto {
  return { 
    items: items.map(i => ({ bahanKey: i.bahanKey, quantity: i.quantity }))
  };
}

export const pantryService = {
  async get(userId: string): Promise<PantryDto> {
    return toDto(await pantryRepository.find(userId));
  },
  async replace(userId: string, input: PutPantryInput): Promise<PantryDto> {
    const uniqueKeys = new Set<string>();
    const items: { bahanKey: string; quantity: string | null }[] = [];
    
    for (const item of input.items) {
      const key = item.bahanKey.trim();
      if (key.length > 0 && !uniqueKeys.has(key)) {
        uniqueKeys.add(key);
        items.push({ bahanKey: key, quantity: item.quantity ?? null });
      }
    }
    
    return toDto(await pantryRepository.upsert(userId, items));
  },
};
