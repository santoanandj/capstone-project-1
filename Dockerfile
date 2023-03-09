FROM node:16.13.1 As build
WORKDIR /usr/app
COPY . /usr/app
RUN npm install
RUN npm run build

FROM nginx:latest
COPY --from=build /usr/app/build /usr/share/nginx/html
