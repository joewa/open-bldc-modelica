within OpenBLDC.Tests.Commutation;
model IntBEMF1 "Commutation based on BEMF integration"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(redeclare
      Blocks.SensorlessCtrl3phStateGraphNG                                         sensorlessCtrl3phPWM(redeclare
        Blocks.DetectCommutationIntBEMF                                                                                                     detectCommutation), mechanicalLoad(w_fixed = 8000 * 2 * Modelica.Constants.pi / 60), motorVoltageCommand(k = 0.8));
  annotation(experiment(StopTime = 0.003));
end IntBEMF1;
