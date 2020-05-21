#!/bin/bash

gmx pdb2gmx -f 1h2c.pdb -o 1h2c.gro -p system.top -water spce -ignh << EOF
14
EOF

gmx editconf -f 1h2c.gro -o newbox.gro -bt cubic -d 1.0
gmx solvate -cp newbox.gro -cs spc216.gro -p system.top -o solv.gro

gmx grompp -f em.mdp -c solv.gro -p system.top -o ions.tpr -maxwarn 2
gmx genion -s ions.tpr -o solv_ions.gro -p system.top -pname NA -nname CL -neutral << EOF
13
EOF

gmx grompp -f em.mdp -c solv_ions.gro -p system.top -o em.tpr -maxwarn 1
gmx mdrun -v -deffnm em

gmx grompp -f pr.mdp -c em.gro -p system.top -o pr.tpr -r em.gro -maxwarn 1
gmx mdrun -v -deffnm pr

gmx grompp -f md.mdp -c pr.gro -p system.top -o md.tpr -maxwarn 1


