within OpenBLDC.Interfaces;
partial model LoadPort "Base model of the converter load port"
  Modelica.Electrical.Analog.Interfaces.PositivePin pLoad "Positive pin of the load circuit" annotation(Placement(transformation(extent = {{50,-110},{70,-90}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin nLoad "Negative pin of the load circuit" annotation(Placement(transformation(extent = {{-70,-110},{-50,-90}}, rotation = 0)));
  Modelica.SIunits.Voltage vLoad "Voltage of the load port";
  Modelica.SIunits.Current iLoad "Current of the load port";
  Modelica.SIunits.Power powerLoad "Power of the load port";
equation
  vLoad = pLoad.v - nLoad.v;
  iLoad = pLoad.i;
  0 = nLoad.i + pLoad.i;
  // stoert vielleicht
  powerLoad = vLoad * iLoad;
  annotation(Documentation(info = "<html>
    <p>
    Contains the basic connectors for the converter DC load side.
    </p>
    </html>", revisions = "<html>
    <table border=\"1\" rules=\"groups\">
    <thead>
    <tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
    </thead>
    <tbody>
    <tr><td>1.0.0</td>  <td>2006-02-20</td>  <td> </td></tr>
    </tbody>
    </table>
    </html>"), Icon(coordinateSystem(preserveAspectRatio = true)), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics = {Line(points = {{-40,-100},{40,-100}}, color = {0,0,0}),Polygon(points = {{-40,-100},{-33,-98},{-33,-102},{-40,-100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid),Text(extent = {{-10,-90},{10,-100}}, lineColor = {0,0,0}, fillColor = {0,0,0}, fillPattern = FillPattern.Solid, textString = "vLoad")}));
end LoadPort;