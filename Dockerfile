# Stage 1 – Build the Next.js app
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2 – Run the production build
FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app ./

# Expose the production port
EXPOSE 3000

# Start Next.js in production mode
CMD ["npm", "start"]
