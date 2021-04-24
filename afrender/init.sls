Install dependencies:
  pkg.installed:
    - pkgs:
      - libpython3.7
      - libpq5
      - xorg #will be installed by default, but it is needed for the Vagrant image or the blender binary will error out

#download the CGRU packages
/tmp/cgru.tar.xz:
  file.managed:
    - source: https://sourceforge.net/projects/cgru/files/3.2.0/cgru.3.2.0.debian10_amd64.tar.gz/download
    - mode: 0700
    - user: root
    - group: root
    - skip_verify: True #this is only for the hash of the file, the SSL cert should still be checked


/tmp/cgru:
  archive.extracted:
    - source: /tmp/cgru.tar.xz
    - enforce_toplevel: False

Install CGRU packages:
  pkg.installed:
    - sources:
      - cgru-common: /tmp/cgru/cgru-common.3.2.0_debian10_amd64.deb
      - afanasy-common: /tmp/cgru/afanasy-common.3.2.0_debian10_amd64.deb
      - afanasy-render: /tmp/cgru/afanasy-render.3.2.0_debian10_amd64.deb


afrender:
  service.running:
    - enable: True

/opt/cgru/config.json:
  file.managed:
    - source: salt://{{ slspath }}/files/config.json
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
    - listen_in:
      - service: afrender


### DEPLOY BLENDER ###
/tmp/blender.tar.xz:
  file.managed:
    - source: https://ftp.nluug.nl/pub/graphics/blender/release/Blender2.92/blender-2.92.0-linux64.tar.xz
    - mode: 0700
    - user: root
    - group: root
    - skip_verify: True #this is only for the hash of the file, the SSL cert should still be checked

/usr/local/blender-installation:
  archive.extracted:
    - source: /tmp/blender.tar.xz
    - options: "--strip-components=1"
    - enforce_toplevel: False

/opt/cgru/software_setup/setup_blender.sh:
  file.managed:
    - source: salt://{{ slspath }}/files/setup_blender.sh
    - user: root
    - group: root
    - mode: 0755
    - listen_in:
      - service: afrender

