

# RESULTADOS DEL PROYECTO. 

## <span style="color:Darkgoldenrod">**OBJETIVO DEL PROYECTO.**</span>  

![](https://img.freepik.com/vector-gratis/gente-diminuta-positiva-sentada-caminando-cerca-gran-objetivo-flecha-aislada-ilustracion-vectorial-plana-equipo-negocios-dibujos-animados-logrando-meta-o-objetivo-concepto-estrategia-logro-marketing_74855-10139.jpg)   

Para poder observar los resultados obtenidos a lo largo de este proyecto, es importante regresar al plateamiento de los objetivos tanto el principal como los especificos.  

En el caso de los **_objetivos especificos_** se determinan los siguientes puntos. 

|Objetivo especifico| Resultado|
|---|:----|
|1. Conseguir la información de los comentarios hechos en la red social Twitter. | Se utilizó un método de scraping en lenguaje R, y se consiguieron 1735 Tweets |
|2. Preparar y limpiar los datos para su procesamiento.  | Se utilizaron las librerías de numpyn pandas, Spacy, re, etc. para la limpieza de los datos |
|3. Hacer uso de algoritmos que nos ayuden a realizar el procesamiento de los datos y análisis de sentimientos. | Se usaron las siguientes librerías  textblob para optener el análisis de sentimiento, wordcloud, altair y sklearn para el modelado estadístico y realizar regresión logística |
|4. Interpretar la información obtenida y sacar las conclusiones del proyecto.   | Se usaron graficos con Seaborn, wordcloud, matplotlib, sklearn y para visualizar la percepción de los ciudadanos y clasificar y predecir el sentimiento de los tweets  |

### Objetivo Principal. 
Recordemos que el objetivo principal era el siguiente:

> El objetivo del proyecto es poder realizar un análisis de sentimiento sobre lo que la gente está mencionando en redes sociales, específicamente por Twitter y poder determinar si ellos están a favor o en contra de este proyecto y poder definir con una regresión logística o SVM para determinar un modelo que ayude a clasificar los siguientes tweets como positivos o negativos.  

Por lo mencionado en los puntos especificos, se puede concluir que se ha podido conseguir llegar al  principal objetivo, el cuál en la parte de metodología y conclusiones podemos sustentar esta afirmación. 

## <span style="color:Darkgoldenrod">**METODOLOGÍA.**</span>   

![](https://conceptodefinicion.de/wp-content/uploads/2020/09/Metodologia-1.jpg)  

Los objetivos mencionados anteriormente se fueron realizando con la siguiente metodología. 

1. Scraping de redes sociales.
    - Limpieza de los datos
2. Análisis de sentimientos con el uso de la librería spaCy
3. Visualización de la información con el uso de la librería Scikit Learn.

### Visualización con Geopandas

Se puede observar que el municipio de Guadalajara y Zapopan son son los municipios con mayor cantidad de vehículos en circulación registrados durante el período 2010 al 2020, así mismo el crecimiento exponencial en la población en dichos municipios.
 
 Por lo tanto el interés surgio por analizar el proyecto de movilidad a implementar por el Gobierno del Estado por abordar una de las problematicas que limitan que la ciudadania realice bastante recorrido diario para llegar a sus destinos.
 
[![Geopandas.png](https://i.postimg.cc/pTygzNj8/Geopandas.png)](https://postimg.cc/sQd6CNwD)


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

En el mismo archivo anterior [Proyecto_final_equipo_2_analisis_de_textos.ipynb](https://github.com/LUISVALLARTA/Proyecto_final/blob/main/src/Proyecto_final_equipo_2_analisis_de_textos.ipynb), se desarrolló también la parte de Spacy, donde se determinó la función "spacy_analyzer", la función extract_entities para la extracción de entidades.

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
```

### **Análisis de sentimientos con el uso de la librería TextBlob**

``` python
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


### **Visualización de la información obtenida del Análisis de Sentimiento.**  


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
[![Grafica-de-barras.png](https://i.postimg.cc/7YNV8G3M/Grafica-de-barras.png)](https://postimg.cc/rKKW5pYK)    


**Grafica de barras con sentimiento positivo y negativo.**

```python
text_tweets['Sentimiento'].value_counts()

alt.Chart(tipo_sentimiento).mark_bar().encode(
    alt.X("Sentimiento:N", sort= '-y',title="Sentimiento del Tweet", bin=False),
    alt.Y('frecuencia:Q', title="Número de Tweets"),
    alt.Color('Sentimiento', legend=None)
).properties(width=alt.Step(150),
    title="Número de tweets pos sentimiento sobre el Proyecto"
)
```
[![Grafica-sentimi-image.png](https://i.postimg.cc/Xvqgt6wq/Grafica-sentimi-image.png)](https://postimg.cc/p9N8n7cM)   


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
[![Grafica-de-pastel.png](https://i.postimg.cc/8zKmc2n7/Grafica-de-pastel.png)](https://postimg.cc/k2SbhpCC)

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
[![Palabras-positivas.png](https://i.postimg.cc/3wzjCgh7/Palabras-positivas.png)](https://postimg.cc/mcNFT1h6)



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
[![Palabras-negativas.png](https://i.postimg.cc/251FZ0P2/Palabras-negativas.png)](https://postimg.cc/SXpM0fQM)

### **Herramientas de la libreria Scikit Learn para predicción del modelo usando una regresión logística** 

```python
print(confusion_matrix(y_test, mod_logreg_pred))
print("\n")
print(classification_report(y_test,mod_logreg_pred))

style.use('classic')
cm = confusion_matrix(y_test, mod_logreg_pred, labels=mod_logreg.classes_)
disp = ConfusionMatrixDisplay(confusion_matrix = cm, display_labels=mod_logreg.classes_)
disp.plot()
```
[![confusion-matrix.png](https://i.postimg.cc/jdTXFQ7S/confusion-matrix.png)](https://postimg.cc/YjXY4FR5)  

Tanto el modelo de regresión logística y el Support Vector Machine que son métodos para algoritmos supervisados obtuvieron una precisión del 97.92% para clasificar el sentimiento de los tweets, dando un gran valor al modelo de predicción para determinar el sentimiento de los próximos tweets.
```python
mod_logreg = LogisticRegression()
mod_logreg.fit(x_train, y_train)
mod_logreg_pred = mod_logreg.predict(x_test)
mod_logreg_acc = accuracy_score(mod_logreg_pred, y_test)
print("Test de Precisión: {:.2f}%".format(mod_logreg_acc*100))
```

```python
svc_pred = SVCmodel.predict(x_test)
svc_acc = accuracy_score(svc_pred, y_test)
print("test de precicion: {:.2f}%".format(svc_acc*100))
```

[![Metrics.png](https://i.postimg.cc/C5M50xnD/Metrics.png)](https://postimg.cc/ftFDjZKT)

## <span style="color:Darkgoldenrod"> **CONCLUSIONES**</span>  

Algunas de las conclusiónes que puedenmencionar son las siguientes: 

+ Guadalajara al tener una población menor y un área (km2) menor a la de Zapopan presenta una mayor concentración de vehículos registrados en circulación durante el período 2010 - 2020.
+ Fueron 1735 tweets obtenidos de la API de Twitter a través de Scraping
+ De la muestra obtenida se obtuvieron más tweets positivos que negativos sobre el proyecto
+ Las palabras con mayor frecuencia en los tweets positivos por mencionar algunas: propuesta, real Colima, ampliación. Las cuáles serán medidas que ayuden o aporten a la movilidad en la ciudad ante un creciente aumento de vehículos y personas.
+ Las palabras con mayor frecuencia en los tweets negativos fueron: López Mateos, gobernador, límites, movilidad, entre otras. Esto ante la situación actual de la avenida que los usuarios llegan a quejarse día a día del tráfico intenso.
+ Se arrojo una precisión general del modelo de regresión logística y Support Vector Machin del 97.92% (teniendo un buen modelo para clasificar los siguientes tweets en positivos o negativos).

En general el proyecto tiene una opinión entre neutral sesgada hacia la positiva, lo cuál es un tabulador positivo para continuar con el proyecto.

### **Puntos de mejora en el Proyecto**  
+ Algunos puntos que podrían ser interesantes para este análisis es poder conseguir datos extras de los usuarios que podrían ser de ayuda para este análisis, cómo edad de los usuarios sexo y en que zona de la ciudad residen.  

+ La ubicación de los tweets y detectar el origen de las opiniones positivas o negativas, si provienen de algún nicho en especifico y desarrollar mejor el análisis y observar la población estudio.

+ Y añadir libreria o crear algortimos de procesamiento de texto en lenguaje español, debido a que la mayoría de las librerias de procesamiento de lenguaje natural se encuentran en ingles y puede distorsionar algunos resultados en la clasificación de sentimientos.

