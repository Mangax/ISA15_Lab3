#!/usr/bin/env python

import os
import subprocess

# We perform the simulation
os.environ["PATH"] += os.pathsep + "/software/mentor/modelsim_6.2/linux/"
os.environ["LM_LICENSE_FILE"] = "1717@led-x3850-3.polito.it"

os.system("echo $PATH")
os.system("echo $LM_LICENSE_FILE")

print ("Starting simulation...")
os.system("source /software/scripts/init_msim6.2g")
process = subprocess.call(["vsim", "-c", "-do", "compile.do"])
print ("Simulation completed")


