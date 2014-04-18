mercurial:
  pkg.installed

git:
  pkg.installed

debconf-utils:
  pkg.installed

emacs:
  pkg.installed

vim:
  pkg.installed

build-essential:
  pkg.installed

python-pip:
  pkg.installed

/etc/hosts:
  file.managed:
    - source: salt://etc/hosts
    - user: root
    - group: root
    - mode: 644
