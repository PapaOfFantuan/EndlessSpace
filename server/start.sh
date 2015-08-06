#!/bin/bash


CMD=$*
echo $CMD
erl -pa ${CMD} -s endless_space 
