FROM node:13.12.0-alpine as builder

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH


# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install --silent


# add app
COPY . ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html