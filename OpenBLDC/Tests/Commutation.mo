within OpenBLDC.Tests;
package Commutation "Tests of commutation algorithms"
  extends Modelica.Icons.ExamplesPackage;
  model ZeroCrossings1 "Commutation based on BEMF zero crossing detection"
    extends Modelica.Icons.Example;
    extends Assemblies.SensorlessBLDC(
      redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(
        redeclare Blocks.DetectCommutationZeroCrossing detectCommutation));

    annotation (experiment(StopTime=0.003));
  end ZeroCrossings1;

  model IntBEMF1 "Commutation based on BEMF integration"
    extends Modelica.Icons.Example;
    extends Assemblies.SensorlessBLDC(
      redeclare Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM(
        redeclare Blocks.DetectCommutationIntBEMF detectCommutation));

    annotation (experiment(StopTime=0.003));
  end IntBEMF1;
end Commutation;
