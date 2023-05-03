# Herramientas y métodos de análisis de tweets generados sobre el proyecto "Plan Integral de Movilidad en el Sur de la Zona Metropolitana de Guadalajara")

![](https://www.informador.mx/__export/1682077371144/sites/elinformador/img/2023/04/21/imagen_imagen_1__lxpez_mateos_-_perifxrico_crop1682077366417.jpg_69363498.jpg)
  
  [Fuente: El Informador](https://www.informador.mx/Vialidad-Definen-obras-para-bajar-trafico-en-sur-de-ciudad-l202304210001.html)

### Fuente de Datos
<div style="text-align: justify"> La extracción de tweets es través de un código en el lenguaje R que permite la conexión a la API de Twitter mediante una claves. 
  
  Los datos son extraídos en formatos csv y el código generado se puede observar en el siguiente enlace: [Scraping Tweets](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/src/CodigoR_Scraping_Tweets.R)
  

# Analís de sentimiento sobre el "Plan integral de movilidad para el sur de la ciudad" en redes sociales.  

## Introducción.  

El día jueves 20 de abril del año 2023 en gobernador del Estado de Jalisco presento el **_"Plan integral de movilidad para el sur de la ciudad"_** el cuál consta de una inversión de 28 mil 500 millones de pesos a largo plazo con la idea de poder resolver los problemas de movilidad en la Zona Sur del Área Metropolitana de Guadalajara, en donde se proponen un BRT en Carretera a Chapala, Ampliación de la Línea 1 del Tren Ligero, dos nuevas rutas y acciones en la Línea 4. Pero hay algo importante a preguntarse y esto es **_¿Qué fue lo que la gente opino?_**. 

Esa pregunta es lo que este proyecto busca responder desarrollando un **_análisis de sentimiento_** sobre los tweets de las personas hablando al respecto. 

Podemos definir el _análisis de sentimiento_ como el proceso de determinar el tono emocional detrás de una serie de palabras. La herramienta de análisis de sentimiento es una técnica automatizada para extraer información significativa de las personas, relacionada con sus actitudes, emociones y opiniones.  

#### **_En que consiste el proyecto de movilidad._** 
Este proyecto es el resultado de las 159 mil propuestas que hicieron los 46 mil 500 ciudadanos que participaron en la consulta y las mesas de diálogo que realizó el Gobierno del Estado desde el año pasado y en donde se tomó en cuenta la participación de los ciudadanos para tener una solución integral a todo el problema de movilidad en la Zona Sur de la ciudad.

La primera propuesta es la creación de una nueva ruta del transporte público, especialmente diseñada para tener una mejor operación del sistema en la zona sur.

La segunda alternativa la ampliación de la línea 1 del Tren Eléctrico hasta los límites de Santa Anita y San Agustín”.

También se va a tomar en cuenta la construcción de la Línea 4 y todas las obras complementarias de este proyecto que ya está en proceso y la cuarta propuesta es el BRT de la carretera a Chapala, que es su primera etapa iría desde el Periférico hasta el entronque del Circuito Sur Metropolitano.

Todas estas propuestas están sustentadas en la meta de reducir el uso del transporte particular y fomentar el uso del transporte público.

Además para complementar estas acciones se instalarán cinco módulos viales desde Santa Anita en donde se tendrán grúas, motos, elementos viales para aplicar la restricción de los horarios de circulación del transporte de carga.
De la misma manera asistencia vial, solución a choques lamineros, mover las unidades involucradas en choques lamineros y para lo cual harán convenios con las aseguradoras.
Así de forma global y a grandes rasgos se tiene la propuesta de solución a los problemas viales del sur de Guadalajara, pero algunos proyectos deberán ser continuadas por la siguiente administración para hacerlas realidad. 

![](https://www.eloccidental.com.mx/incoming/dvks6o-plan-integral.jpg/ALTERNATES/LANDSCAPE_768/Plan%20integral.jpg)  
[Imagen descargada de "El Occidente"](https://www.eloccidental.com.mx/local/alfaro-presento-el-plan-integral-de-movilidad-para-la-zona-sur-9946867.html)  


## Objetivo del proyecto. 

![](https://img.freepik.com/vector-gratis/gente-diminuta-positiva-sentada-caminando-cerca-gran-objetivo-flecha-aislada-ilustracion-vectorial-plana-equipo-negocios-dibujos-animados-logrando-meta-o-objetivo-concepto-estrategia-logro-marketing_74855-10139.jpg)   
El objetivo del proyecto es poder realizar un análisis de sentimiento sobre lo que la gente está mencionando en redes sociales, específicamente por Twitter y poder determinar si ellos están a favor o en contra de este proyecto.  

Para poder llegar a nuestro objetivo general será necesario cumplir con los siguientes objetivos específicos.  
  

1. Conseguir la información de los comentarios hechos en la red social Twitter. 
2. Preparar y limpiar los datos para su procesamiento.  
3. Hacer uso de algoritmos que nos ayuden a realizar el procesamiento de los datos. 
4. Interpretar la información obtenida y sacar las conclusiones del proyecto.   



## Metodología. 
![](https://conceptodefinicion.de/wp-content/uploads/2020/09/Metodologia-1.jpg)   
Los objetivos mencionados anteriormente se fueron realizando con la siguiente metodología. 

1. Scraping de redes sociales.
    - Limpieza de los datos
2. Análisis de sentimientos con el uso de la librería spaCy
3. Visualización de la información con el uso de la librería Scikit Learn.


### Scraping de redes sociales
Para la obtención de la informaciion se utilizo un método de scraping en **_R studio_** utilizando la paquetería de  **_rtweet_**. 
El código que se utlizó se puede ver más a detalles en el archivo **CodigoR_Scraping_Tweets.R**  localizado en la carpeta **src** o haciendo **[click aquí](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/src/CodigoR_Scraping_Tweets.R)**  


La función que se utlizo fue la siguiente.


```r
#función 
tweets <- function(word, count) {
  frecuency <- searchTwitter(word, n=count)
  df <- twListToDF(frecuency)
  return (df)
}

#palabras que se buscaron
word1 <- as.data.frame(tweets("Plan integral de movilidad", 3000))
word2 <- as.data.frame(tweets("Dialogo por la movilidad sustentable de Lopez Mateos", 3000))
...
word12 <- as.data.frame(tweets("planeación y Ordenamiento Territorial", 3000))

# Se concatenan todas las palabras para armar un solo dataframe
tweets_mov_lp <- rbind(word1, word2, word3, word4, word5, word6, word7, word8, word9, word10, word11, word12)

# Se exporta en formato excel
write.xlsx(tweets_mov_lp, "Plan_integral_movilidad.xlsx")


```

Donde se buscaron las siguientes palabras para tratar de conseguir la información más certertera. 

+ "Plan integral de movilidad"
+ "Dialogo por la movilidad sustentable de Lopez Mateos"
+ "Avenida Lopez Mateos"
+ "Tren ligero linea 4"
+ "Ampliación tren ligero linea 1"
+ "Segundo piso Lopez Mateos"
+ "BRT Chapala"
+ "Transporte Jalisco"
+ "Solución lopez mateos"
+ "Modulos Ocelotes"
+ "Camino Real a Colima"
+ "Planeación y Ordenamiento Territorial"

#### Limpieza de los datos.

Ya una vez obteniendo los datos, el siguiente paso sería la limpieza de ellos. 
En el notebook **Proyecto_final_equipo_2_analisis_de_textos.ipynb** en la misma carpeta scr podemos ver como se llevo acabo este paso de forma más detallada.  
De igual manera se muestra a continuación una parte del código utlizado para la limpieza. 

```python

#Realizamos limpieza de información sobre el texto de los tweets
def limpiar_texto(text):
    text = text.lower()
    text = re.sub(r'@[A-Za-z09]+','',text)
    text = re.sub(r'\@w+|\#','',text)
    text = re.sub(r'rt[\s]+','',text)
    text = re.sub(r'https:\/\/?','',text, flags=re.MULTILINE)
    text = re.sub(r'[^\w\s]','',text)
    text_tokens = word_tokenize(text)
    filtered_text = [w for w in text_tokens if not w in stop_words]
    return " ".join(filtered_text)

```


### Análisis de sentimientos con el uso de la librería spaCy


### Visualización de la información con el uso de la librería Scikit Learn.


## Conclusiones




<br>
Maestría en Ciencia de Datos de Posgrados CUCEA de la Universidad de Guadalajara.  

![](https://raw.githubusercontent.com/vcuspinera/UDG_MCD_Project_Dev_II/main/actividades/img/MCD_logo.png)
