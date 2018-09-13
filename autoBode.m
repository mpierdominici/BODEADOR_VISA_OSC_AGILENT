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
              
               
               obj.fg=setFrequency(obj.fg,obj.frequencyVector(i));%seteo la frecuencia del generador de funciones
               updateSin(obj.fg);%mando la informacion al generador de funciones
               obj.os.horizontalScale=0.25*(1/(1000*(obj.frequencyVector(i))));%ajusto la escala horizontal del osciloscopio en funcion de la frecuencia seteada en el generador
               updateHscale(obj.os);%actualizo la escala horizontal en el osciloscopio
               
               pause(obj.establishmentTime);%pauso la ejecucion para que se estabilize
          
               obj.os=obj.os.autoScale(obj.channelInput);%ajusto la escala vertical de los canales
               obj.os=obj.os.autoScale(obj.channelOutput);%
               
               promFase=measPhase(obj.os,obj.channelOutput,obj.channelInput);
               
               if promFase < 0
                   promFase=promFase+360;
               end
                   
               for j=1:4
                   measFase=measPhase(obj.os,obj.channelOutput,obj.channelInput);
                   if  measFase < 0
                        measFase= measFase+360;
                   end
                   promFase=( measFase+promFase)/2;
                   
               end
               
               
               %cargo los datos en un vector, donde la primer columan es
               %frecuencia en kHz, la segunda columna es la tension de
               %entrada, la tercer columna es la tension de salida y la
               %cuarta columna es la fase. // las tenciones son
               %peak-to-peak
               if first==1
                   datos=[obj.frequencyVector(i) ,measPeakToPeak(obj.os,obj.channelInput),measPeakToPeak(obj.os,obj.channelOutput),promFase];
                   first=0;
               else
                   datos=[datos; [obj.frequencyVector(i) ,measPeakToPeak(obj.os,obj.channelInput),measPeakToPeak(obj.os,obj.channelOutput),promFase]];
               end
               
           end
        end
        
   
    end
    
end