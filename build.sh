#!/bin/bash
gcc -c fileresizer.S -o fileresizer.o
gcc fileresizer.o -o fileresizer
