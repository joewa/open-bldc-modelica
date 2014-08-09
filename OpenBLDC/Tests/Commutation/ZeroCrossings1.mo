within OpenBLDC.Tests.Commutation;
model ZeroCrossings1 "Commutation based on BEMF zero crossing detection"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(redeclare Blocks.DetectCommutationZeroCrossingSimple detectCommutation), mechanicalLoad(w_fixed = 8000 * 2 * Modelica.Constants.pi / 60), motorVoltageCommand(k = 0.8));
  annotation(experiment(StopTime = 0.003));
end ZeroCrossings1;