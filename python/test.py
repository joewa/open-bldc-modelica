# file: test.py
#!/usr/bin/python
import OMPython
cmds =	["loadModel(Modelica)",
	"model test end test;",
	"loadFile(\"../OpenBLDC/package.mo\")",
	"simulate(OpenBLDC.Assemblies.HallCalibration, stopTime=0.25)",
	"plot(h)"]

for cmd in cmds:
	answer = OMPython.execute(cmd)
	print "\nResult:\n%s" %answer

