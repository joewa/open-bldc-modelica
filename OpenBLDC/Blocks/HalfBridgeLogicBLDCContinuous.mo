within OpenBLDC.Blocks;
block HalfBridgeLogicBLDCContinuous "Generate the gate signals"
  extends Modelica.Blocks.Icons.BooleanBlock;
  Modelica.Blocks.Interfaces.RealInput val "0 or > 0 or < 0" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput pulses
    "Pulses from the PWM generator"                                              annotation(Placement(transformation(extent = {{-120,58},{-80,98}})));
  Modelica.Blocks.Interfaces.IntegerInput pwm_Mode "Set the PWM mode" annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));

  Modelica.Blocks.Interfaces.RealOutput hCtrl annotation(Placement(transformation(extent={{90,50},
            {110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl annotation(Placement(transformation(extent={{90,-70},
            {110,-50}})));
equation
  if pwm_Mode == 1 and val > 0.5 then
    hCtrl = pulses;  // pulses;
    lCtrl = true;  // not pulses;
  elseif pwm_Mode == 1 and val < (-0.5) then
    hCtrl = 1.0 - pulses;  // not pulses;
    lCtrl = true;  // pulses;
  elseif pwm_Mode == 2 and val > 0.5 then
    hCtrl = pulses;
    lCtrl = true;  // not pulses;
  elseif pwm_Mode == 2 and val < (-0.5) then
    hCtrl = 0.0;  // false;
    lCtrl = true;
  //elseif pwm_Mode == 3 and val > 0.5 then
  //  hCtrl = pulses;
  //  lCtrl = false;
  //elseif pwm_Mode == 3 and val < (-0.5) then
  //  hCtrl = false;
  //  lCtrl = pulses;
  else
    hCtrl = 0.0;  // false;
    lCtrl = false;
  end if;

  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics),
      Documentation(info="<html>
<p>There are three methods to generate the switching signals of the half bridges...</p>
<p>This block is more generic than HalfBridgeLogicINSD.</p>
</html>"));
end HalfBridgeLogicBLDCContinuous;