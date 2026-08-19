import type { FastifyInstance } from "fastify";
import { logger } from "../infra/logger";

export async function healthCheckRoute(app: FastifyInstance) {
  app.get("/health", async (_request, reply) => {
    logger.info("Health check endpoint called.");
    return reply.status(200).send({ status: "OK!" });
  });
}
