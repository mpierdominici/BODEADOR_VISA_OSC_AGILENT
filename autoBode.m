classdef autoBode
    properties
        os %%oscilloscope
        fg %%function generator
        Ifrequency
        Ffrequency
        currentFrequency
        channelInput
        channelOutput
        data
        establishmentTime
        isLineal
        points
        frequencyVector
        peakToPeak
    end
    
    methods
        function obj = autoBode(Doscilloscope,DfunctionGenerator,peakToPeak,StartFrequency,StopFrequency,channelInput,channelOutput,establishmentTime,isLineal,points)
        obj.os=Doscilloscope;
        obj.fg=DfunctionGenerator;
        obj.Ifrequency=StartFrequency;
        obj.Ffrequency=StopFrequency;
        obj.channelInput=channelInput;
        obj.channelOutput=channelOutput;
        obj.establishmentTime=establishmentTime;
        obj.isLineal=isLineal;
        obj.points=points;
        obj.peakToPeak=peakToPeak;
        
        obj.fg=setPeakToPeak(obj.fg,obj.peakToPeak);
        obj.fg=setFrequency(obj.fg,obj.Ifrequency);
        updateSin(obj.fg);
        
        if isLineal == 1
            obj.frequencyVector=linspace(obj.Ifrequency,obj.Ffrequency,obj.points);
        else
            obj.frequencyVector=logspace(log10(obj.Ifrequency),log10(obj.Ffrequency),obj.points);
        end
       
        
        end
        
        function run(obj)
           for i=1:(obj.points)
               obj.fg=setFrequency(obj.fg,obj.frequencyVector(i));
               updateSin(obj.fg);
               
               pause(obj.establishmentTime);
               
               
               
           end
        end
        
   
    end
    
end