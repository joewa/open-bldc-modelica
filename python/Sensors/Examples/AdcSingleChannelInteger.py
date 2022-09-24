# file: TestPWM.py
#!/usr/bin/python
import OMPython
cmds =  ["loadModel(Modelica)",
        "model test end test;",
        "loadFile(\"../../../OpenBLDC/package.mo\")",
        "simulate(OpenBLDC.Sensors.Examples.AdcSingleChannelInteger, fileNamePrefix=\"Result\")"]

_omc = OMPython.OMCSession()
for cmd in cmds:
        answer = _omc.sendExpression(cmd)
        print "\nResult:\n%s" %answer
        if not answer:
                print _omc.sendExpression("getErrorString()")


