# CMS

- [Payload](https://github.com/payloadcms/payload)
  - `npx create-payload-app@latest` with the "blank" template

## Local development

Start the database

```sh
$ docker compose start mongo
```

Start the UI

```sh
$ npm run dev
```

## Creating and serving a build

To run Payload in production, you need to build and serve the Admin panel. To do so, follow these steps:

```sh
$ npm run build   # creates `./build`
$ npm run serve   # serves from `./build`
```
