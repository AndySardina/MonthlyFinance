=====================
entity_data_generator
=====================


This projects contains a set of utilities for populating the needed data for different entities.


Description
===========

Let's say that you want to create the SQL inserts for the currency entity. Then you should execute the following comand:

```bash
$ genEntity --entity-type currency --output-dir ./MontlyFinanceData
```

The ```genEntity``` will be available once you install the project.

Note
====

This project has been set up using PyScaffold 3.1. For details and usage
information on PyScaffold see https://pyscaffold.org/.
