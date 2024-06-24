# Kong logging with Elastic stack (ELK) on Docker

_Based on the Anthony Lapenna's [docker-elk](https://github.com/deviantony/docker-elk/tree/main) repository._

---

## Contents

1. [Usage](#usage)
1. [Ports](#ports)
1. [Configuration](#configuration)
   * [How to configure Elasticsearch](#how-to-configure-elasticsearch)
   * [How to configure Kibana](#how-to-configure-kibana)
   * [How to configure Logstash](#how-to-configure-logstash)

## Usage

1. Initialize the Elasticsearch users and groups required by executing the command:

```sh
docker-compose up setup
```

2. Start the stack components:

```sh
docker-compose up [-d]
```

Give Kibana about a minute to initialize, then access the Kibana web UI by opening <http://localhost:5601> in a web
browser and use the following (default) credentials to log in: *elastic*/*password*

> [!NOTE]
> Upon the initial startup, the `elastic`, `logstash_internal` and `kibana_system` Elasticsearch users are intialized
> with the values of the passwords defined in the [`.env`](.env) file (_"password"_ by default). The first one is the
> [built-in superuser][builtin-users], the other two are used by Kibana and Logstash respectively to communicate with
> Elasticsearch.

## Ports

By default, the stack exposes the following ports:

* **50000**: Logstash TCP input
* **9600**: Logstash monitoring API
* **9200**: Elasticsearch HTTP
* **9300**: Elasticsearch TCP transport
* **5601**: Kibana

## Configuration

> [!IMPORTANT]
> Configuration is not dynamically reloaded, you will need to restart individual components after any configuration
> change.

### How to configure Elasticsearch

The Elasticsearch configuration is stored in [`elasticsearch/config/elasticsearch.yml`][config-es].

You can also specify the options you want to override by setting environment variables inside the Compose file:

```yml
elasticsearch:

  environment:
    network.host: _non_loopback_
    cluster.name: my-cluster
```

Please refer to the following documentation page for more details about how to configure Elasticsearch inside Docker
containers: [Install Elasticsearch with Docker][es-docker].

### How to configure Kibana

The Kibana default configuration is stored in [`kibana/config/kibana.yml`][config-kbn].

You can also specify the options you want to override by setting environment variables inside the Compose file:

```yml
kibana:

  environment:
    SERVER_NAME: kibana.example.org
```

Please refer to the following documentation page for more details about how to configure Kibana inside Docker
containers: [Install Kibana with Docker][kbn-docker].

### How to configure Logstash

The Logstash configuration is stored in [`logstash/config/logstash.yml`][config-ls].

You can also specify the options you want to override by setting environment variables inside the Compose file:

```yml
logstash:

  environment:
    LOG_LEVEL: debug
```

Please refer to the following documentation page for more details about how to configure Logstash inside Docker
containers: [Configuring Logstash for Docker][ls-docker].


[builtin-users]: https://www.elastic.co/guide/en/elasticsearch/reference/current/built-in-users.html

[config-es]: ./elasticsearch/config/elasticsearch.yml
[config-kbn]: ./kibana/config/kibana.yml
[config-ls]: ./logstash/config/logstash.yml

[es-docker]: https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
[kbn-docker]: https://www.elastic.co/guide/en/kibana/current/docker.html
[ls-docker]: https://www.elastic.co/guide/en/logstash/current/docker-config.html
