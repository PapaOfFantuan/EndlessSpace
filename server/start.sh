#!/bin/bash
erl -pa ebin deps/cowboy/ebin deps/cowlib/ebin deps/json/ebin deps/json_patch_tests/ebin deps/jsonfilter/ebin deps/jsonpointer/ebin deps/jsx/ebin deps/ranch/ebin -s endless_space 
