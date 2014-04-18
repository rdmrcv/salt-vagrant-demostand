mysql-server:
  pkg.installed

mysql-client:
  pkg.installed

python-mysqldb:
  pkg.installed

mysql:
  service:
    - running
    - enable: True

/etc/mysql/my.cnf:
  file.managed:
    - source: salt://mysql/my.cnf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: mysql

{{ pillar['database']['name'] }}:
{% if (pillar['database']['withUser']) %}
  mysql_user.present:
    - host: localhost
    - password: {{ pillar['database']['password'] }}
    - require:
      - service: mysql
      - pkg: python-mysqldb
{% endif %}
  mysql_database.present:
    - character_set: utf8
    - collate: utf8_general_ci
    - connection_use_unicode: True
    - connection_charset: utf8
    - saltenv: 
        - LC_ALL: "en_US.utf8"
    - require:
      - service: mysql
      - pkg: python-mysqldb
{% if (pillar['database']['withUser']) %}
{{ pillar['database']['name'] }}-grants:
  mysql_grants.present:
    - database: "{{ pillar['database']['name'] }}.*"
    - grant: all privileges
    - user: {{ pillar['database']['name'] }}
    - host: localhost
    - require:
      - service: mysql
      - mysql_database: {{ pillar['database']['name'] }}
      - mysql_user: {{ pillar['database']['name'] }}
      - pkg: python-mysqldb
{% endif %}