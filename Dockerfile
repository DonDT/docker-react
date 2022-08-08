FROM node:16-alpine as builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


# New from means second phase, you don't have to declare that previous has stopped
FROM nginx 
# copy folder from previous phase # docs nginx serves this after saving data in it
COPY --from=builder /app/build /usr/share/nginx/html

