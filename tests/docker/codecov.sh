#!/bin/bash
R --no-echo --no-restore -e 'covr::codecov(quiet = FALSE)'