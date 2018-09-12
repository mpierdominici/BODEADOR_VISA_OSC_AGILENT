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
        
        function datos = run(obj)
            first=1;
           for i=1:(obj.points)
               if first==1
                 
               end
               
               obj.fg=setFrequency(obj.fg,obj.frequencyVector(i));
               updateSin(obj.fg);
               obj.os.horizontalScale=0.25*(1/(1000*(obj.frequencyVector(i))));
               updateHscale(obj.os);
               pause(obj.establishmentTime);
          
               obj.os=obj.os.autoScale(obj.channelInput);
               obj.os=obj.os.autoScale(obj.channelOutput);
               if first==1
                 datos=[obj.frequencyVector(i) ,measPeakToPeak(obj.os,obj.channelOutput),measPeakToPeak(obj.os,obj.channelInput),measPhase(obj.os,obj.channelOutput,obj.channelInput)];
               first=0;
               end
               datos=[datos; [obj.frequencyVector(i) ,measPeakToPeak(obj.os,obj.channelOutput),measPeakToPeak(obj.os,obj.channelInput),measPhase(obj.os,obj.channelOutput,obj.channelInput)]];
               
           end
        end
        
   
    end
    
end