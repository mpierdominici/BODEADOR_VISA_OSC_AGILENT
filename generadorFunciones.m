function [ ] = generadorFunciones(equipo,tensionPeakToPeak,frecuencia,offset,formaOnda,duty)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

dataToSend='*IDN?';

switch formaOnda
   case 'sin'
       dataToSend='APPLy:SINusoid <100> ,<2>,<0> ';
   case 'sq'
   case 'ramp'
      
 
    otherwise
        fprintf(equipo,dataToSend);
       
      
end

