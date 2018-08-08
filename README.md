# Fio Formula

[Fio](http://kernel.ubuntu.com/~cking/stress-ng/) is a benchmarking tool to exercise multiple computer subsystems such as CPU, memory, IO and networking. This [salt formula](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html) can be used to install it from the package repository or from source, and execute stress-ng on the provided job file(s).

See the full Salt Formulas installation and usage instructions [here](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).
## What this formula offers

* stressng.install - to install stressng (from the OS packages - the default,  or from source if the pillar stress:lookup:install_from_source is set). For example:
```
salt \* state.apply stressng.install pillar='{"stressng":{"lookup": {"install_from_source": True}}}'
```
You can also set the stress-ng version via a lookup pillar *stressng_source_url*; the stress-ng source archives are [available here](http://kernel.ubuntu.com/~cking/tarballs/stress-ng/).

* stressng.execute - run stress-ng with the job-file(s) specified in the pillar. The job file(s) is(are) created and stored in the /files subfolder. Each job file will be executed sequentially.

The output directory (*out_dir*) is specified in the pillar. The formula will create a subdirectory under the out_dir folder whose name will correspond to the job-file name. All the stress-ng results for that job file will be stored in this subdirectory. The job file will also be stored in this subdirectory under the filename job.stress.

Look at the _pillar.example_ file for more examples.