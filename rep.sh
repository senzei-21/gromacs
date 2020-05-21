#!/bin/bash

for d in ./*/ ; do
			(cd "$d" && gmx mdrun -v -deffnm md)
		done


