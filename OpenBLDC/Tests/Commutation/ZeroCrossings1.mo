within OpenBLDC.Tests.Commutation;
model ZeroCrossings1 "Commutation based on BEMF zero crossing detection - MSL4-OK"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(
      redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(
        catchStart(KV_Method = 2),
        redeclare Blocks.DetectCommutationZeroCrossing detectCommutation),
      mechanicalLoad(w_fixed = 8000 * 2 * Modelica.Constants.pi / 60), motorVoltageCommand(k = 0.8));
  annotation(experiment(StopTime = 0.003));
end ZeroCrossings1;
