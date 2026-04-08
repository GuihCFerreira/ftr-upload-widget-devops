FROM node:20.18

RUN npm install -g pnpm

# Define the working directory inside the container
WORKDIR /usr/src/app

COPY package.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile --prod=false

COPY . .

RUN pnpm build

# Remove development dependencies to reduce the image size
RUN pnpm prune --prod

ENV CLOUDFLARE_ACCESS_KEY_ID="#"
ENV CLOUDFLARE_SECRET_ACCESS_KEY="#"
ENV CLOUDFLARE_BUCKET="#"
ENV CLOUDFLARE_ACCOUNT_ID="#"
ENV CLOUDFLARE_PUBLIC_URL="http://localhost:8080"

# Expose the port that the application will run on
EXPOSE 3333

# Start the application
CMD ["pnpm", "start"]