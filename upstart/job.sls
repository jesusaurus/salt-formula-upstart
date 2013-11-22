# Copyright 2013 Hewlett-Packard Development Company, L.P.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
{% macro job(service, command, description, user='root', group=None, chdir=None, expect=None, start_trigger=None, stop_trigger=None) %}

/etc/init/{{ service }}.conf:
  file.managed:
    - source: salt://upstart/job.conf
    - template: jinja
    - context: {
      command: "{{ command }}",
      description: {{ description or false }},
      user: {{ user or false }},
      group: {{ group or false }},
      chdir: {{ chdir or false }},
      expect: {{ expect or false }},
      start_trigger: {{ start_trigger or false }},
      stop_trigger: {{ stop_trigger or false }} }

{{ service }}:
  service.running:
    - require:
      - file: /etc/init/{{ service }}.conf

{% endmacro %}
