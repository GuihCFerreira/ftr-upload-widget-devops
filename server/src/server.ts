import { fastify } from "fastify";
import { fastifyCors } from "@fastify/cors";
import { uploadImageRoute } from "./routes/upload-image";
import { fastifyMultipart } from "@fastify/multipart";
import { healthCheckRoute } from "./routes/health-check";
import { logger } from "./infra/logger";

const server = fastify();

server.register(fastifyCors, {
  origin: "*",
});

server.register(fastifyMultipart);
server.register(uploadImageRoute);
server.register(healthCheckRoute);

server.listen({ port: 3333, host: "0.0.0.0" }).then(() => {
  logger.info("HTTP server running.");
});
