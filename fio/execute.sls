{% from "fio/map.jinja" import exec_fio as exec_fio_map with context %}
{% set fio_path = exec_fio_map.get('stressng_path','/usr/local/bin/fio') %}
{% set cli_args = exec_fio_map.get ('cmd_cli_args','') %}
{% set job_file_list = exec_fio_map.get ('job_file_list',[]) %}
{% set out_dir = exec_fio_map.get('out_dir','/tmp/outputdata') %}
{% set test_id = grains.get('testgitref','no_test_id_grain') %}
{% set minion_id = grains.get('host', 'no_hostname_grain' ) %}
{% set disk_file = grains.get('disk_file','/dev/null') %}
{% set runtime = exec_fio_map.get('runtime',60) %}
check_and_setup:
  cmd.run:
    - name: '{{ fio_path }} -h'
  file.directory:
    - name: {{ out_dir }}

{% for job_file in job_file_list %}
{% set test_out_dir = [out_dir,job_file] | join('/') %}

run_fio_jobfile_{{job_file}}:
  file.managed:
    - name: {{ test_out_dir }}/fio.job
    - source: salt://fio/files/{{ job_file }}
    - requires: 
      - file.directory  
    - makedirs: True

{% set base_cmd_list = ( [fio_path, cli_args,
['--output=',test_out_dir,'/fio.output']|join(''),
['--filename=',disk_file]|join(''),
['--runtime=',runtime]| join('') ] ) %}


  cmd.run:
    - name: {{ base_cmd_list | join(' ') }}  {{ test_out_dir }}/fio.job
    - requires:
      - check_and_setup
      - file.managed
{% endfor %}




    