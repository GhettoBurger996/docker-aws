FROM node:alpine
RUN apk update
WORKDIR /app

COPY package.json /app

# To Fix Permissions for Packages
RUN npm config set unsafe-perm true
RUN npm install --force

COPY . /app

RUN npm run build

# RUN chown -R node /app/node_modules
# USER node

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html