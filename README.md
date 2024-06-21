# Kong Training Material

## Prerequisites

* Docker installed

```bash
$ docker -v 
```
Should display the version of Docker installed


## Running custom Kong JavaScript plugins in a DB-less mode

1. Building the Docker image:

```bash
$ docker build --platform linux/amd64 --no-cache -t kong-custom-img .
```

2. Check that the image built correctly:

```bash
$ docker run -it --rm kong-custom-img kong version
```

3. Start Kong Gateway in DB-less mode:

⚠ This command assumes you have a plugin named `my-plugin` located in the `./plugins` directory. Adjust the command as needed to ensure that the `KONG_PLUGINS` environment variable includes the necessary plugins: `bundled` for Kong's built-in plugins, followed by the names of your custom plugins.

```bash
$ docker run -d --name kong-custom-img \
 -v "$(pwd)/config:/kong/declarative/" \
 -v "$(pwd)/plugins:/usr/local/kong/js-plugins" \
 -e "KONG_DATABASE=off" \
 -e "KONG_DECLARATIVE_CONFIG=/kong/declarative/kong.yml" \
 -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
 -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
 -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
 -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
 -e "KONG_ADMIN_LISTEN=0.0.0.0:8001" \
 -e "KONG_ADMIN_GUI_URL=http://localhost:8002" \
 -e "KONG_PLUGINSERVER_NAMES=js" \
 -e "KONG_PLUGINSERVER_JS_SOCKET=/usr/local/kong/js_pluginserver.sock" \
 -e "KONG_PLUGINSERVER_JS_START_CMD=/usr/local/bin/kong-js-pluginserver -v --plugins-directory /usr/local/kong/js-plugins" \
 -e "KONG_PLUGINSERVER_JS_QUERY_CMD=/usr/local/bin/kong-js-pluginserver --plugins-directory /usr/local/kong/js-plugins --dump-all-plugins" \
 -e "KONG_PLUGINS=bundled,my-plugin" \
 -p 8000:8000 -p 8001:8001 -p 8002:8002 \
 kong-custom-img
```
