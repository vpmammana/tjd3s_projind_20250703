#!/bin/bash

cd "$(dirname "$0")"

./insert_tokens.bash | sort | uniq > insert_tokens.sql
