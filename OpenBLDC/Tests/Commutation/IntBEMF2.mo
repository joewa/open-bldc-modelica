within OpenBLDC.Tests.Commutation;
model IntBEMF2
  "Commutation based on BEMF integration with extended method, 2-leg-PWM"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(
      redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(
        catchStart(KV_Method = 3),
        redeclare Blocks.DetectCommutationIntBEMFext detectCommutation(
          sampleAll=false,sampleHi=true,sampleLo=true),
        PwmMode=1),
      mechanicalLoad(w_fixed = 8000 * 2 * Modelica.Constants.pi / 60), motorVoltageCommand(k = 0.8));
  annotation(experiment(StopTime = 0.003));
end IntBEMF2;
