within OpenBLDC.Interfaces;
partial model SupplyPort "Base model of the converter (DC)-supply port"
  import Modelica.Units.SI;
  Modelica.Electrical.Analog.Interfaces.PositivePin pSupply(final v(start = 0))
    "Positive pin of the supply circuit"                                                                             annotation(Placement(transformation(extent = {{-110,50},{-90,70}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin nSupply(final v(start = 0))
    "Negative pin of the supply circuit"                                                                             annotation(Placement(transformation(extent = {{-110,-70},{-90,-50}}, rotation = 0)));
  parameter SI.Current IConverterMax(min = 0)
    "Maximum admissible converter DC supply current"                                                         annotation(Dialog(tab = "Reference values and limits"));
  SI.Voltage vSupply "Voltage of the supply port";
  SI.Current iSupply "Current of the supply port";
  SI.Power powerSupply "Power of the supply port";
equation
  vSupply = pSupply.v - nSupply.v;
  iSupply = pSupply.i;
  0 = nSupply.i + pSupply.i;
  // stoert vielleicht
  powerSupply = iSupply * vSupply;
  assert(iSupply <= IConverterMax, "Converter current exceeded maximum admissible current of the supply port (IConverterMax = " + String(IConverterMax) + "A)");
  assert(vSupply >= 0, "The voltage of the supply port must be greater than zero! (vSupply = " + String(vSupply) + "V)");
  annotation(Documentation(info = "<html>
    <p>
    Contains the basic connectors, parameters and asserts for the converter DC supply side.
    </p>
    </html>", revisions = "<html>
    <table border=\"1\" rules=\"groups\">
    <thead>
    <tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
    </thead>
    <tbody>
    <tr><td>1.0.0</td>  <td>2006-02-20</td>  <td> </td></tr>
    <tr><td>1.0.3</td>  <td>2006-03-29</td>  <td> Redefined some start values </td></tr>
    <tr><td>     </td>  <td>2006-05-02</td>  <td> Changed vSupply &gt; 0 to vSupply &gt;= 0 </td></tr>
    <tr><td>     </td>  <td>2006-08-31</td>  <td> Improved assert statements </td></tr>
    </tbody>
    </table>
    </html>"), Icon(coordinateSystem(preserveAspectRatio = true)), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics={  Line(points=  {{-100,40},{-100,-40}}, color=  {0,0,0}),Polygon(points=  {{-100,-41},{-102,-33},{-98,-33},{-100,-41}}, lineColor=  {0,0,0}, fillColor=  {0,0,0},
            fillPattern=                                                                                                    FillPattern.Solid),Text(extent=  {{-96,10},{-76,0}}, lineColor=  {0,0,0}, fillColor=  {0,0,0},
            fillPattern=                                                                                                    FillPattern.Solid, textString=  "vSupply")}));
end SupplyPort;
