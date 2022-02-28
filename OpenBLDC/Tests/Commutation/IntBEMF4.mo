within OpenBLDC.Tests.Commutation;
model IntBEMF4
  "Commutation based on BEMF integration with extended method, 2-leg-PWM interupted; MSL 4.0 KO"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(
      redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(
        catchStart(KV_Method = 3),
        redeclare Blocks.DetectCommutationIntBEMFext detectCommutation(
          sampleAll=false,sampleHi=true,sampleLo=false),
        PwmMode=3),
      mechanicalLoad(w_fixed = 8000 * 2 * Modelica.Constants.pi / 60), motorVoltageCommand(k = 0.6));
  annotation(experiment(StopTime = 0.003));
end IntBEMF4;
