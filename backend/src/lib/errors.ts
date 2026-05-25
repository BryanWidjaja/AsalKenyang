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

export const badRequest = (msg: string) =>
  new AppError(400, msg, "BAD_REQUEST");
export const unauthorized = (msg = "Unauthorized") =>
  new AppError(401, msg, "UNAUTHORIZED");
export const notFound = (msg = "Not found") =>
  new AppError(404, msg, "NOT_FOUND");
export const conflict = (msg: string) => new AppError(409, msg, "CONFLICT");
