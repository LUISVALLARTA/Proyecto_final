# **Herramientas y técnicas para analisis de Tweets sobre el proyecto "Plan Integral de Movilidad en el sur de la Ciudad de la ZMG"**

## <span style="color:Darkgoldenrod">**INTRODUCCIÓN.**</span>
  

El día jueves 20 de abril del año 2023 en gobernador del Estado de Jalisco presento el **_"Plan integral de movilidad para el sur de la ciudad"_** el cuál consta de una inversión de 28 mil 500 millones de pesos a largo plazo con la idea de poder resolver los problemas de movilidad en la Zona Sur del Área Metropolitana de Guadalajara, en donde se proponen un BRT en Carretera a Chapala, Ampliación de la Línea 1 del Tren Ligero, dos nuevas rutas y acciones en la Línea 4. Pero hay algo importante a preguntarse y esto es **_¿Qué fue lo que la gente opino?_**. 

Esa pregunta es lo que este proyecto busca responder desarrollando un **_análisis de sentimiento_** sobre los tweets de las personas hablando al respecto. 

Podemos definir el _análisis de sentimiento_ como el proceso de determinar el tono emocional detrás de una serie de palabras. La herramienta de análisis de sentimiento es una técnica automatizada para extraer información significativa de las personas, relacionada con sus actitudes, emociones y opiniones.  

![](https://getbuzzmonitor.com/wp-content/uploads/analisis-sentimiento.jpg) 

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


## <span style="color:Darkgoldenrod">**OBJETIVO DEL PROYECTO.**</span>  

![](https://img.freepik.com/vector-gratis/gente-diminuta-positiva-sentada-caminando-cerca-gran-objetivo-flecha-aislada-ilustracion-vectorial-plana-equipo-negocios-dibujos-animados-logrando-meta-o-objetivo-concepto-estrategia-logro-marketing_74855-10139.jpg)   

El objetivo del proyecto es poder realizar un análisis de sentimiento sobre lo que la gente está mencionando en redes sociales, específicamente por Twitter y poder determinar si ellos están a favor o en contra de este proyecto.  

Para poder llegar a nuestro objetivo general será necesario cumplir con los siguientes objetivos específicos.  

1. Conseguir la información de los comentarios hechos en la red social Twitter. 
2. Preparar y limpiar los datos para su procesamiento.  
3. Hacer uso de algoritmos que nos ayuden a realizar el procesamiento de los datos. 
4. Interpretar la información obtenida y sacar las conclusiones del proyecto.   


## <span style="color:Darkgoldenrod">**METODOLOGÍA.**</span>   

![](https://conceptodefinicion.de/wp-content/uploads/2020/09/Metodologia-1.jpg)  

Los objetivos mencionados anteriormente se fueron realizando con la siguiente metodología. 

1. Scraping de redes sociales.
    - Limpieza de los datos
2. Análisis de sentimientos con el uso de la librería spaCy
3. Visualización de la información con el uso de la librería Scikit Learn.


### **Scraping de redes sociales**  

![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQwi0JY_v_ooebuAL9rrx_argIguI__Cq9mLm7CFHFpA-vvYXRMbg86Dq0QBe2DfUEYIc&usqp=CAU)  

Para la obtención de la información se utilizó un método de scraping en **_R studio_** utilizando la paquetería de  **_rtweet_**. 
El código que se utilizó se puede ver más a detalles en el archivo **CodigoR_Scraping_Tweets.R**  localizado en la carpeta **src** o haciendo **[click aquí](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/src/CodigoR_Scraping_Tweets.R)**  

La función que se utilizo fue la siguiente.


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

### **Limpieza de los datos.**  

![](https://datascientest.com/es/wp-content/uploads/sites/7/2021/05/illu_data_cleaning_blog_2-07.png)  

Una vez obteniendo los datos y extrayéndolos, el siguiente paso sería la limpieza de ellos. 
En el documento, [Proyecto_final_equipo_2_analisis_de_textos.ipynb](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/src/Proyecto_final_equipo_2_analisis_de_textos.ipynb) en la misma carpeta scr podemos ver como se llevó a cabo este paso de forma más detallada.  
De igual forma se muestra a continuación una parte del código que se utilizó para la limpieza de los datos. 


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


text_tweets = text_tweets.drop_duplicates('text')
text_tweets.info()

#tokenizar el texto en palabras y en oraciones:
tokens = texto.apply(nltk.word_tokenize)
tokens

#Eliminamos las stopwords (palabras sin significado como "y", "o", etc.):
from nltk.corpus import stopwords

stopwords_sp = stopwords.words('spanish')

texto['tokens_sin_stopwords'] = tokens.apply(lambda x: [palabra for palabra in x if palabra.lower() not in stopwords_sp])

```
De esta manera conseguimos tener un dataset prácticamente limpio para empezar a usar la librería de Spacy.


### **Análisis de sentimientos con el uso de la librería spaCy**

![](https://spacy.io/_next/static/media/social_default.96b04585.jpg)  

En el mismo archivo anterior [Proyecto_final_equipo_2_analisis_de_textos.ipynb](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/src/Proyecto_final_equipo_2_analisis_de_textos.ipynb), se desarrolló también la parte de Spacy, donde se determinó la función "spacy_analyzer", la función extract_entities para la extracción de entidades y poder determinar un valor al tweet, es decir, si el usuario estaba de acuerdo con el proyecto, se muestra neutro, o si está en desacuerdo. 

Se deja una muestra del código utilizado en esta parte del proceso den análisis. 


```python
def spacy_analyzer(text):
    doc = nlp(text)
    return doc

doc = texto['textos_analizados'] = text_tweets["text"].apply(spacy_analyzer)

#Extracción de entidades nombradas (NER)
def extract_entities(text):
    doc = nlp(text)
    entities = []
    for entity in doc.ents:
        entities.append((entity.text, entity.label_))
    return entities
texto['entidades_nombradas'] = text_tweets['text'].apply(extract_entities)
texto['entidades_nombradas'] 

##Análisis del tipo de la sintaxis de las palabras de los tweets
def analyze_syntax(text):
    doc = nlp(text)
    return [(token.text, token.pos_, token.dep_, token.head.text) for token in doc]

text_tweets['analisis_sintactico'] = text_tweets['text'].apply(analyze_syntax)
text_tweets['analisis_sintactico'] 

text_tweets['Subjetividad'] = text_tweets['text'].apply(get_subjectivity)
text_tweets['Polaridad'] = text_tweets['text'].apply(get_polarity)
text_tweets.head()

def sentimiento(score):
    if score < 0:
        return "Negativo"
    elif score == 0:
        return "Neutral"
    else:
        return "Positivo"

text_tweets["Sentimiento"] = text_tweets['Polaridad'].apply(sentimiento)
text_tweets.head()
```


### **Visualización de la información con el uso de la librería  Scikit Learn & Matplotlib.**  

Acontinuación se muestran algunas de las visualizaciónes en las que nos apoyamos para el análisis de los datos. 

**Grafica de barras.**

```python
text_tweets['Sentimiento'].value_counts()

plt.title("Número de Tweets por sentimiento sobre el proyecto de movilidad urbana en el sur de la ciudad")
plt.xlabel('Sentimento')
plt.ylabel('Número de tweets')
text_tweets['Sentimiento'].value_counts().plot(kind='bar')
plt.show()
```
<img src="Grafica de barras.png" alt="Drawing" style="width: 900px;"/>  
![](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/doc/Grafica%20de%20barras.png?raw=true)    

**Grafica de circular.**

```python
fig = plt.figure(figsize=(7,7))
colores = ("yellowgreen", "gold", "red")
wp = {'linewidth': 2, 'edgecolor': "black"}
tags = text_tweets['Sentimiento'].value_counts()
explode= (0.1,0.1,0.1)
tags.plot(kind='pie', autopct='%1.1f%%', shadow = True, colors=colores,
         startangle=90, wedgeprops=wp, explode=explode, label='')
plt.title('Distribución % del sentimiento en los tweets')
```
<img src="Grafica de pastel.png" alt="Drawing" style="width: 600px;"/>

**WordCloud sobre los tweets positivos**

```python
# palabras mas frecuentes de los comentarios positivos
text1 = ' '.join([word for word in tweets_positivos['text']])
plt.figure(figsize=(10,10),facecolor="None")
wordcloud = WordCloud(width=500, height=300, random_state=21, max_font_size=119).generate(text1)
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')
plt.show()
```
<img src="Palabras positivas.png" alt="Drawing" style="width: 600px;"/>



**WordCloud sobre los tweets negativos**
```python
# palabras mas frecuentes de los comentarios negativos
text2 = ' '.join([word for word in tweets_negativos['text']])
plt.figure(figsize=(10,10),facecolor="None")
wordcloud = WordCloud(width=500, height=300, random_state=21, max_font_size=119).generate(text2)
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')
plt.show()
```
<img src="Palabras negativas.png" alt="Drawing" style="width: 600px;"/>

**Predicción del modelo usando una regresión logística**

```python
print(confusion_matrix(y_test, mod_logreg_pred))
print("\n")
print(classification_report(y_test,mod_logreg_pred))

style.use('classic')
cm = confusion_matrix(y_test, mod_logreg_pred, labels=mod_logreg.classes_)
disp = ConfusionMatrixDisplay(confusion_matrix = cm, display_labels=mod_logreg.classes_)
disp.plot()
```
[confusion-matrix.png](https://postimg.cc/YjXY4FR5)  
<img src="confusion_matrix.png" alt="Drawing" style="width: 600px;"/>

## <span style="color:Darkgoldenrod"> **CONCLUSIONES**</span>  

Algunas de las conclusiones a las que se llegaron están mencionadas en el file del código [Proyecto_final_equipo_2_analisis_de_textos.ipynb](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/src/Proyecto_final_equipo_2_analisis_de_textos.ipynb) , las cuales se mencionan a continuación. 

+ Guadalajara al tener una población menor y un área (km2) menor a la de Zapopan presenta una mayor concentración de vehículos registrados en circulación durante el período 2010 - 2020.
+ Fueron 1735 tweets obtenidos de la API de Twitter a través de Scraping
+ De la muestra obtenida se obtuvieron más tweets positivos que negativos sobre el proyecto
+ Las palabras con mayor frecuencia en los tweets positivos por mencionar algunas: propuesta, real Colima, ampliación. Las cuáles serán medidas que ayuden o aporten a la movilidad en la ciudad ante un creciente aumento de vehículos y personas.
+ Las palabras con mayor frecuencia en los tweets negativos fueron: López Mateos, gobernador, límites, movilidad, entre otras. Esto ante la situación actual de la avenida que los usuarios llegan a quejarse día a día del tráfico intenso.
+ Se arrojo una precisión general del modelo de regresión logística y Support Vector Machin del 97.92% (teniendo un buen modelo para clasificar los siguientes tweets en positivos o negativos).
