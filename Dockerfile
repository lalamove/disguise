FROM node:12.20-slim

WORKDIR /usr/src/app

RUN npm install -g @angular/cli@9.1.15
ADD package.json .
RUN yarn install
ADD . .

RUN ng build

COPY        --from=wtfcoderz/static-healthcheck /healthcheck /
HEALTHCHECK --interval=10s --timeout=2s --start-period=1s --retries=2 CMD ["/healthcheck", "-tcp", "127.0.0.1:4200"]

EXPOSE 4200

CMD ["ng", "serve"]
