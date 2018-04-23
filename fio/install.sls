{% from "fio/map.jinja" import install_fio as fio_map with context %}
{% set package = fio_map.get('package', 'fio') %}
{% set install_from_source = fio_map.get('install_from_source', False) %}

{% if install_from_source==False %}
install_stress_package:
  pkg.installed:
    - name: {{ package }}
{% else %}
{% set prereqs = fio_map.get('prereq_packages',[]) %}
{% set fiourl = fio_map.get('fio_source_url','url_needed')  %}

install_prereqs:
  pkg.latest:
    - pkgs: {{ prereqs }}

download_source:
  cmd.run:
    - names: 
      - rm -rf fio*
      - wget {{ fiourl }} -O fio.tar.gz
    - cwd: /tmp

compile_source:
  cmd.script:
    - name: compileinstall.sh
    - source: salt://fio/files/compileinstall.sh
    - requires:
      - install_prereqs
      - download_source

{% endif %}
    
    

