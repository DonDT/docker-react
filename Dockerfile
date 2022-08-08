FROM node:16-alpine as builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


# New from means second phase, you don't have to declare that previous has stopped
FROM nginx 
# this is the port that any CI-CD tool circle-ci, elastic, travis ci would read and expose the application to.
EXPOSE 80
# copy folder from previous phase # docs nginx serves this after saving data in it
COPY --from=builder /app/build /usr/share/nginx/html

