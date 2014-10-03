# file: TestPWM.py
#!/usr/bin/python
import OMPython
cmds =  ["loadModel(Modelica)",
        "model test end test;",
        "loadFile(\"../../OpenBLDC/package.mo\")",
        "simulate(OpenBLDC.Tests.TestPWM, fileNamePrefix=\"Result\", stopTime=0.25)",
        "plot(pulseWidthVar.y)"]

_omc = OMPython.OMCSession()
for cmd in cmds:
        answer = _omc.sendExpression(cmd)
        print "\nResult:\n%s" %answer
        if not answer:
                print _omc.sendExpression("getErrorString()")


