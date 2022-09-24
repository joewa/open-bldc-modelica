# file: test.py
#!/usr/bin/python
import OMPython
cmds =  ["loadModel(Modelica)",
        "model test end test;",
        "loadFile(\"../../../OpenBLDC/package.mo\")",
        "simulate(OpenBLDC.Tests.Commutation.IntBEMF1)",
	"simulate(OpenBLDC.Tests.Commutation.IntBEMF2)",
	"simulate(OpenBLDC.Tests.Commutation.IntBEMF3)",
	"simulate(OpenBLDC.Tests.Commutation.IntBEMF4)"]

_omc = OMPython.OMCSession()
for cmd in cmds:
        answer = _omc.sendExpression(cmd)
        print "\nResult:\n%s" %answer
        if not answer:
                print _omc.sendExpression("getErrorString()")


