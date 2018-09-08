classdef functionGenerator
    properties
        device
        frequency
        peakToPeak
        offset
        dutyCycle
    end
    methods
        %functionGenerator , constructor
        %addres -> visa address
        %
        function obj = functionGenerator(address)
            %obj.device=visa('agilent', address);
            obj.frequency=0;%seteo las variables en cero
            obj.dutyCycle=0;
            obj.offset=0;
            obj.peakToPeak=0;
        end
        
        function obj = setFrequency(obj,frequency)
           obj.frequency=frequency;
        end
        
        function obj = setPeakToPeak(obj,peakToPeak)
           obj.peakToPeak=peakToPeak;
        end
        
        function obj = setOffset(obj,offset)
           obj.offset=offset;
        end
        
        function updateSin(obj)
            %falta buscar en la documentacion como mandar esta data
        end
     
        function status = getCurrentStatus(obj)
           status= obj.frequency;
           status=[status,obj.peakToPeak];
           status=[status,obj.offset];
           status=[status,obj.dutyCycle];
        end
       end
    
  
    
end