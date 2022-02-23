# multistep process

# first step: build
FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
# that will put everything to the /app/build
RUN npm run build

# second step: take result of previous step and serve
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# nginx will auto start, so no RUN command needed