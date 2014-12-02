within OpenBLDC.Blocks;
model PulseWidthVar
  "Generates a boolean pulse signal with adjustable pulse width and period"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  Modelica.Blocks.Interfaces.RealInput dutyCycle annotation(Placement(transformation(extent = {{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput periodTime annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput active annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "PWM output" annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
protected
  Boolean doSample;
  discrete Real nextSampling(start = Modelica.Constants.inf);
  discrete Real pulsStart(start = Modelica.Constants.inf);
equation
  doSample = time >= pre(nextSampling);
  when {doSample,edge(active)} then
    if edge(active) then
      nextSampling = time + periodTime;
      pulsStart = time;
    else
      nextSampling = pre(nextSampling) + periodTime;
      pulsStart = pre(nextSampling);
    end if;
  end when;
  y = time >= pulsStart and time < pulsStart + dutyCycle * periodTime and active;
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), Icon(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end PulseWidthVar;
