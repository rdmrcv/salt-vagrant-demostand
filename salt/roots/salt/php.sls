php5:
  pkg.installed

php5-dev:
  pkg.installed

php5-fpm:
  pkg.installed

php5-cli:
  pkg.installed

php5-common:
  pkg.installed

php-apc:
  pkg.installed

php5-mysql:
  pkg.installed

php5-mcrypt:
  pkg.installed

php5-gmp:
  pkg.installed

php5-gd:
  pkg.installed

php5-curl:
  pkg.installed

php5-xdebug:
  pkg.installed

php-pear:
  pkg.installed

igbinary:
  pecl.installed:
    - require:
      - pkg: php-pear

redis:
  pecl.installed:
    - require:
      - pkg: php-pear

/etc/php5/fpm/php.ini:
  file.managed:
    - source: salt://php/php.ini
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: php5-fpm

/var/run/php5-fpm.sock:
  file.managed:
    - user: www-data
    - group: www-data
    - mode: 644
    - watch_in:
      - service: php5-fpm
