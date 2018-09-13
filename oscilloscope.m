classdef oscilloscope
      properties
        device
        channels
        trigerCahnnel
        trigerLevel
        trigerBW%filtros 
        trigerNR%del
        trigerHF%triger
        trigerSlope
        horizontalScale
      end
    
      methods
          function obj = oscilloscope(address)
             obj.device=visa('agilent', address);
              fopen(obj.device);
             % (channelNumber,verticalScale,probe,offset)
              obj.channels=channel(1,1,1,0,1);
              for i=2:4
                  obj.channels=[obj.channels,channel(i,1,1,0,0)];
              end
              
          end
          
          function updateProbe(obj)
              for i=1:4
                  fprintf(obj.device,[':CHANnel',num2str(obj.channels(i).channelNumber,0),':PROBe ',num2str(obj.channels(i).probe,3)]);
                  fprintf(obj.device,[':CHANnel',num2str(obj.channels(i).channelNumber,0),':OFFSet ',num2str(obj.channels(i).offset,3),' V']);
                  fprintf(obj.device,[':CHANnel',num2str(obj.channels(i).channelNumber,0),':SCALe ',num2str(obj.channels(i).verticalScale,3),' V']);
                
                 fprintf(obj.device,[':CHANnel',num2str(obj.channels(i).channelNumber,0),':DISPlay ',num2str(obj.channels(i).status)]);
                  
              end
              
          end
           
          function  ptp = measPeakToPeak(obj,channel)
              fprintf(obj.device,[':MEASure:VPP? ','CHANnel',num2str(obj.channels(channel).channelNumber,0)]);
              ptp=str2double(fscanf(obj.device));
              
          end
          
          function obj= autoScale(obj,channel)
              
              obj.channels(channel).verticalScale=getVscale(obj,channel);

               while  measPeakToPeak(obj,channel) < (obj.channels(channel).verticalScale)*3
                  obj.channels(channel).verticalScale=(obj.channels(channel).verticalScale)-(0.4)*obj.channels(channel).verticalScale;
                  %updateProbe(obj);
                  updateVscale(obj,channel)
               end
              
              while measPeakToPeak(obj,channel) >= (6*obj.channels(channel).verticalScale)
                  obj.channels(channel).verticalScale=(obj.channels(channel).verticalScale)+3.5*obj.channels(channel).verticalScale;
                  %updateProbe(obj);
                  updateVscale(obj,channel)
              end
              
             
         % measPeakToPeak(obj,channel)
          
          
          end
          
          function updateHscale(obj)
              %:TIMebase:SCALe 15e-9 s
              fprintf(obj.device,[' :TIMebase:SCALe ',num2str(obj.horizontalScale,3),' s']);
          
          end
          
          function updateVscale(obj,i)
           fprintf(obj.device,[':CHANnel',num2str(obj.channels(i).channelNumber,0),':SCALe ',num2str(obj.channels(i).verticalScale,3),' V']);
          end
          
          
          function  vs =getVscale(obj,i)
           %:CHANnel1:SCALe?
              fprintf(obj.device,[':CHANnel',num2str(obj.channels(i).channelNumber,0),':SCALe?']);
              vs=str2double(fscanf(obj.device));
            % [':CHANnel',num2str(obj.channels(i).channelNumber,0),':SCALe?']
          end
          function  phase = measPhase(obj,channel1,channel2)
              
              %:MEASure:PHASe? CHANnel1, CHANnel2
               fprintf(obj.device,[':MEASure:PHASe? ',' CHANnel',num2str(obj.channels(channel1).channelNumber,0),', CHANnel',num2str(obj.channels(channel2).channelNumber,0)]);
             phase=str2double(fscanf(obj.device));
          end
      end
end