### build container
FROM node:current-alpine3.17 as build

RUN addgroup -S app && adduser -S app -G app
RUN mkdir /app
WORKDIR /app
ADD . .
RUN chown -R app:app /app
USER app
RUN npm ci
RUN npm run build

### production container
FROM node:current-alpine3.17

ENV NODE_ENV production

RUN addgroup -S app && adduser -S app -G app
RUN mkdir /app && chown app:app /app
USER app
WORKDIR /app
COPY --from=build /app/package*.json .
# shut be ci but breaks because of inconsistent package-lock.json
RUN npm ci
COPY --from=build /app/build build
ADD entry.js /app

EXPOSE 3000
ENTRYPOINT ["node", "/app/entry.js"]
