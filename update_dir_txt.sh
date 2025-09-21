#!/bin/bash
find . -maxdepth 1 -mindepth 1 -type d ! -name ".git" | sed 's|^\./||' > dir.txt