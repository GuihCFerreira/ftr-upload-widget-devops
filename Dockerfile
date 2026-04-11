FROM node:20.18 AS base

RUN npm install -g pnpm

FROM base AS dependencies

# Define the working directory inside the container
WORKDIR /usr/src/app

COPY package.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile --prod=false

FROM base as build

WORKDIR /usr/src/app

COPY . .

COPY --from=dependencies /usr/src/app/node_modules ./node_modules

RUN pnpm build

# Remove development dependencies to reduce the image size
RUN pnpm prune --prod

FROM cgr.dev/chainguard/node:latest AS deploy

# Use a non-root user for security
USER 1000 

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

ENV CLOUDFLARE_ACCESS_KEY_ID="#"
ENV CLOUDFLARE_SECRET_ACCESS_KEY="#"
ENV CLOUDFLARE_BUCKET="#"
ENV CLOUDFLARE_ACCOUNT_ID="#"
ENV CLOUDFLARE_PUBLIC_URL="http://localhost:8080"

# Expose the port that the application will run on
EXPOSE 3333

# Start the application
CMD ["dist/server.mjs"]