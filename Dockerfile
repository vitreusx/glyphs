FROM node:16.13.2-alpine AS base
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . ./

FROM base AS build
RUN yarn build

FROM build AS dev
EXPOSE 3000
CMD ["yarn", "start"]

FROM build AS test
ENV CI=true
CMD ["yarn", "test"]

FROM nginx:stable-alpine AS prod
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]