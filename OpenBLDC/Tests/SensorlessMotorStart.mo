within OpenBLDC.Tests;
model SensorlessMotorStart
  "Startup of motor with sensorless commutation from zero"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(
    redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(
      redeclare Blocks.DetectCommutationIntBEMF detectCommutation),
    redeclare Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque mechanicalLoad(
      TorqueDirection = false,
      w_nominal = 8000 * 2 * Modelica.Constants.pi / 60, tau_nominal = -0.01),
      motorVoltageCommand(k = 0.8));
  annotation(experiment(StopTime = 0.5));
end SensorlessMotorStart;
