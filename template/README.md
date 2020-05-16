# {{ project_name }}

{% if ci_cd == 'Github' -%}
[![Actions Status](https://github.com/{{ github_username }}/{{ project_slug }}/workflows/CI/badge.svg)](https://github.com/{{ github_username }}/{{ project_slug }}/actions)
{%- endif %}

{%- if project_description %}

{{ project_description }}
{%- endif %}

## API

The server serves the following endpoints.

### `GET /`

Returns the string `Hello World`.

```bash
$ curl http://35.224.1.215/
Hello World
```

## Contributing

Take a look at our [Contributing Guide](CONTRIBUTING.md).
