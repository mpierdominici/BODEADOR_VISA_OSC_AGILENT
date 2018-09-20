# Medidor de respuesta en frecuencia
El objetivo del programa es medir automaticamnte la respuesta en frecuencia de un circuito, controlando un osiloscopio y un generador de funciones para lograrlo.

## Primeros pasos
- Poseer Matlab 2016b o superior.
- Instalar los drivers para los esquipos.(windows https://drive.google.com/open?id=1fXEhHn0nLYQWUKsfQt_i0UVms23hndL4)
- Descargar el repositorio

## Caracterisiticas del programa

- Tension de alimentasion configurable.
- Tiempo de establecimiento configurable.
- Cantidad de puntos y tipo de barrido(lin/log) seleccionable para el usuario.
- Configuracion automatica de escala y vertical para maximisar la precision de la medicion.

## Inicializacion

- Se instancian los objetos de oscilloscope y functionGenerator, pasandoles como unico parametro el VISA ADDRESS de cada equipo.
- se instancia el objeto autoBode de la siguiente manera:
autoBode(Doscilloscope,DfunctionGenerator,peakToPeak,StartFrequency,StopFrequency,channelInput,channelOutput,establishmentTime,isLineal,points)

Donde
- Doscilloscope y DfunctionGenerator, son las instancias de los equipos ya mencionados.
- peakToPeak: tension peak to peak en volts a la que se realizara la medicion.
- StartFrequency: frecuencia en kHz, a la que comienza la medicion.
- StopFrequency: frecuencia en kHz, a la que termina la medicion.
- channelInput: numero de canal, entre 1 y 4, el cual esta conectado a la entrada.
- channelOutput: numero de canal, entre 1 y 4, el cual esta conectado a la entrada.
- establishmentTime: tiempo en segundos que se espera para que se estavilice el circuito.
- isLineal: 1 si el barrido de frecuencia es lineal, 0 si el barrido es logaritmico.
- points: cantidad de frecuencias en el intervalo seteado.

## Medir

Una vez relizada la inicializacion, correr el metodo run de la clase autoBode, este devolvera, luego de relizar la medicion, una matriz con el siguiente formato, primera columna frecuencia en KHz, segunda columna tension peak to peak de entrada en volts, tercer columna tension peak to peak de la salida en volts y la cuarta columna la fase (en grados).
 
 ## Ejemplo
 
 os=oscilloscope('visa adress');
 fg=functionGenerator('visa adress');
 a=autoBode(...);
 datos=run(a);
 csvwrite(datos);





