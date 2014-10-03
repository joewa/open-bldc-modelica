# file: plotTestPWM.py
#!/usr/bin/python
import OMPython
import numpy as np
import matplotlib.pyplot as plt 
import pandas; pandas.set_option('display.max_rows', 5)
from modelicares import SimRes

sim = SimRes('Result_res.mat')
print sim['Time'].IV()
print sim['Time'].FV()
pulses = sim.find('pulse*.y')
sim.plot(pulses);
plt.savefig('test.png')
# plt.show()
# sim['pulseWidthVar.y'].array(t=(0, 0.2 ))
