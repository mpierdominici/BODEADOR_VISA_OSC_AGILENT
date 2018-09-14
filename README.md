# Medidor de respuesta en frecuencia
El objetivo del programa es medir automaticamnte la respuesta en frecuencia de un circuito, controlando un osiloscopio y un generador de funciones para lograrlo.

## Primeros pasos
- Poseer Matlab 2016b o superior.
- Instalar los drivers para los esquipos.
- Descargar el repositorio

## Caracterisiticas del programa

- Tension de alimentasion configurable.
- Tiempo de establecimiento configurable.
- Cantidad de puntos y tipo de barrido(lin/log) seleccionable para el usuario.
- Configuracion automatica de escala y vertical para maximisar la precision de la medicion.

## Como se usa

- Se instancian los objetos de oscilloscope y functionGenerator, pasandoles como unico parametro el VISA ADDRESS de cada equipo.
- se instancia el objeto autoBode de la siguiente manera:
autoBode(Doscilloscope,DfunctionGenerator,peakToPeak,StartFrequency,StopFrequency,channelInput,channelOutput,establishmentTime,isLineal,points)

Donde Doscilloscope y DfunctionGenerator, son las instancias de los equipos ya mencionados.
--peakToPeak



