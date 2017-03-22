---
layout: basic
---

# Darwin AMD64
{% for version in site.data.sha.darwin_amd64 %}
  {{version[0]}}:{{version[1]}}
{% endfor %}

# Linux AMD64
{% for version in site.data.sha.linux_amd64 %}
  {{version[0]}}:{{version[1]}}
{% endfor %}
