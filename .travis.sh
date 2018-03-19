#!/usr/bin/env bash
set -o errexit

#this library behavior has changed - producing spurious warnings which are causing the build to fail
#flake8 --exclude=riak/pb riak *.py

sudo riak-admin security disable

python setup.py test

sudo riak-admin security enable

if [[ $RIAK_TEST_PROTOCOL == 'pbc' ]]
then
    export RUN_SECURITY=1
    python setup.py test --test-suite riak.tests.test_security
else
    echo '[INFO]: security tests run on PB protocol only'
fi
