# Overview

Run [SCTK](http://www.nist.gov/itl/iad/mig/tools.cfm) in a Docker container.  The SCTK includes the following tools:
* sclite
* asclite
* sc_stats
* rover
* and more...

# Docker Hub
The image is available on Docker Hub as [`smithmicro/sctk`](https://hub.docker.com/r/smithmicro/sctk/) with the following tags:

  * `latest`, `2`, `2.4`, `2.4.10` ([Dockerfile](https://github.com/smithmicro/sctk/blob/master/Dockerfile))


# Usage
`sclite` does not operate interactively, so by default, a container will simply print the help screen of program.

```
$ docker run -it smithmicro/sctk
sclite: <OPTIONS>
sclite Version: 2.10, SCTK Version: 1.3
Input Options:
...
```

## Hypothesis Test
To run `sclite` on a reference file and hypothesis file, you need to map a volume to your host:
```
$ docker run -it -v /myhostpath:/var/sctk smithmicro/sctk sclite \
    -i wsj -r ref.txt -h hyp.txt
```

## sc_stats
To run more advanced features of the SDK, shell into the container with a volume mapped to your local files:
```
$ docker run -it -v /myhostpath:/var/sctk smithmicro/sctk sh
/var/sctk #
```
Then run sclite pipled to sc_stats:
```
$ sclite -i wsj -r ref.txt -h hyp1.txt -h hyp2.txt -o sgml stdout \
    | sc_stats -p -t mapsswe -u
sc_stats: 1.3
Beginning Multi-System comparisons and reports
    Performing the Matched Pair Sentence Segment (Word Error) Test
    Printing Unified Statistical Test Reports
        Output written to 'Ensemble.stats.unified'

Successful Completion
```


# Disclaimer

These software packages were developed at the National Institute of Standards and Technology by employees of the Federal Government in the course of their official duties. Pursuant to title 17 Section 105 of the United States Code this software is not subject to copyright protection and is in the public domain. These software packages are experimental systems.  NIST assumes no responsibility whatsoever for its use by other parties, and makes no guarantees, expressed or implied, about its quality, reliability, or any other characteristic. We would appreciate acknowledgement if the software is used. This software can be redistributed and/or modified freely provided that any derivative works bear some notice that they are derived from it, and any modified versions bear some notice that they have been modified.
