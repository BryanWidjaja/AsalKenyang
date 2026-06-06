export class AppError extends Error {
  constructor(
    public readonly statusCode: number,
    message: string,
    public readonly code: string = "ERROR",
  ) {
    super(message);
    this.name = "AppError";
  }
}

export const badRequest = (message: string) =>
  new AppError(400, message, "BAD_REQUEST");

export const unauthorized = (message = "Unauthorized") =>
  new AppError(401, message, "UNAUTHORIZED");

export const notFound = (message = "Not found") =>
  new AppError(404, message, "NOT_FOUND");

export const conflict = (message: string) =>
  new AppError(409, message, "CONFLICT");
