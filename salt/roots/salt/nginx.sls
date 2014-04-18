apache:
  service:
    - dead
    - name: apache2

nginx:
  pkg:
    - installed
  service:
    - running
    - name: nginx
    - enable: True
    - watch:
      - pkg: nginx

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/default
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: nginx
