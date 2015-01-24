within OpenBLDC.Interfaces;
partial model Source "Base model for the energy sources "

  Modelica.Electrical.Analog.Interfaces.PositivePin p
    "Positive pin of the electric source"                                                   annotation(Placement(transformation(extent = {{90,50},{110,70}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    "Negative pin of the electric source"                                                   annotation(Placement(transformation(extent = {{90,-70},{110,-50}}, rotation = 0)));
  parameter Integer ns(min = 1) = 1 "Number of serial connected cells" annotation(Dialog(group = "Size of the package"));
  parameter Integer np(min = 1) = 1 "Number of parallel connected cells" annotation(Dialog(group = "Size of the package"));
  Modelica.SIunits.Voltage vCell "Cell voltage";
  Modelica.SIunits.Current iCell "Cell current";
  Modelica.SIunits.Power powerCell "Cell power";
  Modelica.SIunits.Voltage vPackage "Package voltage";
  Modelica.SIunits.Current iPackage "Package current";
  Modelica.SIunits.Power powerPackage "Package power";
equation
  vPackage = p.v - n.v;
  iPackage = p.i;
  powerPackage = vPackage * iPackage;
  vCell = vPackage / ns;
  iCell = iPackage / np;
  powerCell = vCell * iCell;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics), Documentation(info = "<html>
    <p>
    Contains the basic connectors for energy sources.
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
    </html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics={  Rectangle(extent=  {{-100,100},{100,-100}}, lineColor=  {0,0,127}, fillColor=  {255,255,255},
            fillPattern=                                                                                                    FillPattern.Solid),Text(extent=  {{-150,150},{150,110}}, textString=  "%name", lineColor=  {0,0,255})}));
end Source;
