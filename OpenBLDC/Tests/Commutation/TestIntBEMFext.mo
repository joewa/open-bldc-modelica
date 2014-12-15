within OpenBLDC.Tests.Commutation;
model TestIntBEMFext "Model to understand the linear regression method"
  extends Modelica.Icons.Example;
  Blocks.DetectCommutationIntBEMFext dC(bufsize=10, NREG=10,
    sampleAll=false)
    annotation (Placement(transformation(extent={{0,-6},{20,14}})));
  Modelica.Blocks.Sources.BooleanStep senseBemfStep(startTime=1e-5)
    annotation (Placement(transformation(extent={{-80,42},{-60,62}})));
  Modelica.Blocks.Sources.Constant v_dc(k=2)
    annotation (Placement(transformation(extent={{-22,-76},{-2,-56}})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=1e-5,
    duration=100e-6,
    height=-2,
    offset=2)
    annotation (Placement(transformation(extent={{-46,-40},{-26,-20}})));
  Blocks.PulseWidthVar pulseWidthVar
    annotation (Placement(transformation(extent={{-38,4},{-18,24}})));
  Modelica.Blocks.Sources.Constant period(k=25e-6)
    annotation (Placement(transformation(extent={{-82,-22},{-62,-2}})));
  Modelica.Blocks.Sources.Constant d(k=0.2) "Duty cycle"
    annotation (Placement(transformation(extent={{-82,12},{-62,32}})));

equation
  dC.bridgeState = {0,-1,1};
  dC.KV = 1;
  dC.v[2] = 0;
  dC.v[3] = 0;
  connect(senseBemfStep.y, dC.senseBEMF) annotation (Line(
      points={{-59,52},{10,52},{10,14}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(v_dc.y, dC.v_dc) annotation (Line(
      points={{-1,-66},{16,-66},{16,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp.y, dC.v[1]) annotation (Line(
      points={{-25,-30},{10,-30},{10,-7.33333}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senseBemfStep.y, pulseWidthVar.active) annotation (Line(
      points={{-59,52},{-46,52},{-46,6},{-38,6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(period.y, pulseWidthVar.periodTime) annotation (Line(
      points={{-61,-12},{-50,-12},{-50,14},{-38,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(d.y, pulseWidthVar.dutyCycle) annotation (Line(
      points={{-61,22},{-38,22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senseBemfStep.y, pulseWidthVar.reset) annotation (Line(
      points={{-59,52},{-46,52},{-46,-8},{-28,-8},{-28,3.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pulseWidthVar.pwmControlBusConnectorOut, dC.pwmControlBusConnectorIn)
    annotation (Line(
      points={{-18,8},{0,8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), experiment(StopTime=0.0002),
    Documentation(info="<html>
<p>This demo calculates the slope and the zero crossing of the ramp signal.</p>
</html>"));
end TestIntBEMFext;
