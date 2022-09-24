# file: plotTestPWM.py
#!/usr/bin/python
import OMPython
import numpy as np
import matplotlib.pyplot as plt 
import pandas; pandas.set_option('display.max_rows', 5)
from modelicares import SimRes, SimResList

sims = SimResList('OpenBLDC.Tests.Commutation.IntBEMF*')
print(sims)
# for sim in sims:
sim = sims[0]
strom = sim.find('inverter3ph.i*')
#dict(description=strom.description)
sim.plot(strom[0])
plt.show()

# sim = SimRes('Result_res.mat')
# print sim['Time'].IV()
# print sim['Time'].FV()
# pulses = sim.find('pulse*.y')
# sim.plot(pulses);
# plt.savefig('test.png')
# plt.show()
# sim['pulseWidthVar.y'].array(t=(0, 0.2 ))
