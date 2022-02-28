within OpenBLDC.Tests.Commutation;
model ZeroCrossingExt
  "Commutation based on zero crossing detection extended method, 2-leg-PWM; MSL 4.0 KO"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(
      redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(
        catchStart(KV_Method = 3),
        redeclare Blocks.DetectCommutationIntBEMFext detectCommutation(
          sampleAll=false,sampleHi=true,sampleLo=true,modeSlope=false),
        PwmMode=1),
      mechanicalLoad(w_fixed = 8000 * 2 * Modelica.Constants.pi / 60), motorVoltageCommand(k = 0.8));
  annotation(experiment(StopTime = 0.003), Documentation(info="<html>
<p>Works more robust when the motor has an ugly back EMF shape which makes the slope detection unreliable.</p>
</html>"));
end ZeroCrossingExt;
