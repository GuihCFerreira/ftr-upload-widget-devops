import type { FastifyInstance } from "fastify";

export async function healthCheckRoute(app: FastifyInstance) {
  app.get("/health", async (_request, reply) => {
    return reply.status(200).send({ status: "OK" });
  });
}
