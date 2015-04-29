#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/usr/local/bin/fswatch -o $DIR | xargs -n1 -I{} $DIR/sync.sh $DIR
