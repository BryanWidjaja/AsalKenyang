import bcrypt from "bcrypt";
import { authRepository } from "./auth.repository.js";
import { signAccessToken } from "../../lib/jwt.js";
import { conflict, unauthorized } from "../../lib/errors.js";
import type {
  AuthResponse,
  LoginInput,
  RegisterInput,
} from "../../schemas/auth.js";

const BCRYPT_ROUNDS = 12;

function toAuthResponse(user: {
  id: string;
  email: string;
  createdAt: Date;
}): AuthResponse {
  return {
    token: signAccessToken(user.id),
    user: {
      id: user.id,
      email: user.email,
      createdAt: user.createdAt.toISOString(),
    },
  };
}

export const authService = {
  async register({ email, password }: RegisterInput): Promise<AuthResponse> {
    if (await authRepository.findByEmail(email)) {
      throw conflict("Email already registered");
    }

    const passwordHash = await bcrypt.hash(password, BCRYPT_ROUNDS);
    const user = await authRepository.createUser(email, passwordHash);

    return toAuthResponse(user);
  },

  async login({ email, password }: LoginInput): Promise<AuthResponse> {
    const user = await authRepository.findByEmail(email);

    if (!user || !(await bcrypt.compare(password, user.passwordHash))) {
      throw unauthorized("Invalid email or password");
    }

    return toAuthResponse(user);
  },
};
