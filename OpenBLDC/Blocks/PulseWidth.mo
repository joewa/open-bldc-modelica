within OpenBLDC.Blocks;
block PulseWidth "Generates a boolean pulse signal with adjustable pulse width and period"
  extends Modelica.Blocks.Interfaces.partialBooleanSource;
  Modelica.Blocks.Interfaces.RealInput Tperiod(min = Modelica.Constants.small) "Period of the pulse signal" annotation(Placement(transformation(origin = {-100,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput startTime(min = 0) "Time of the first pulse" annotation(Placement(transformation(origin = {-100,-40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput d "Duty cycle" annotation(Placement(transformation(origin = {-100,40}, extent = {{-10,-10},{10,10}}, rotation = 0)));
protected
  Modelica.SIunits.Time Twidth = d * Tperiod "Width of one pulse" annotation(HideResult = true);
  discrete Modelica.SIunits.Time pulsStart "Start time of the pulse" annotation(HideResult = true);
initial equation
  pulsStart = startTime;
  // generates a pulse signal
equation
  when sample(startTime, Tperiod) then
      pulsStart = time;
  
  end when;
  y = time >= pulsStart and time < pulsStart + Twidth;
  annotation(Documentation(info = "<html>
<p>This block generates pulse signals. The pulse width equals <code>d * T</code> with the period of signal  <code>T</code>. </p>
<p><b>Note</b> that <code>T</code> must be <i>greater than zero</i>. </p>
</html>", revisions = "<html>
<table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-01-17</td>  <td> </td></tr>
</tbody>
</table>
</html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Line(points = {{-40,-70},{-40,20},{0,20},{0,-70}}, color = {0,0,255}, smooth = Smooth.None),Text(extent = {{-54,-66},{-24,-88}}, lineColor = {0,0,0}, textString = "startTime")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end PulseWidth;

