within OpenBLDC.Tests.Commutation;
model HallReluctance
  "Commutation with hall sensors - consider motor with reluctance - MSL4-OK"
  extends Modelica.Icons.Example;
  extends Assemblies.SensorlessBLDC(
      redeclare Blocks.SensorCtrl3phStateGraphNG sensorlessCtrl3phPWM(
        PwmMode=1),
      mechanicalLoad(w_fixed = 8000 * 2 * Modelica.Constants.pi / 60), motorVoltageCommand(k = 0.2));
  annotation(experiment(StopTime = 0.003), Documentation(info="<html>
<p>Works more robust when the motor has an ugly back EMF shape which makes the slope detection unreliable.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end HallReluctance;
