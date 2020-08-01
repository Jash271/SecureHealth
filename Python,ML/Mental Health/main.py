from fastapi import FastAPI, Form, status
import requests
from pydantic import BaseModel
from fastapi import Body, FastAPI
import spacy
import pandas as pd
from fastapi.middleware.cors import CORSMiddleware
from vader_sentiment.vader_sentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()
nlp=spacy.load("en_core_web_sm")
import math
from shortenIt import Bot
from nltk import sent_tokenize, word_tokenize, PorterStemmer
from nltk.corpus import stopwords
import nltk
import requests
import re
import json

app = FastAPI()

origins = ['https://youglance.herokuapp.com',"http://localhost","http://localhost:8080","*"]


app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class Ents(BaseModel):
    query: str
    

def show_ents(x):
    k=[]
    doc=nlp(x)
    for y in doc.ents:
        k.append(y.text)
    ents=set(k)
    
    return ents





@app.post("/fetch")
def sentiment(ents: Ents):
    

    k=analyzer.polarity_scores(ents.query)
    print(k['compound'])
    if int(k['compound'])< -0.5:
        url = f"https://api.spotify.com/v1/search?q=positive&type=playlist&limit=3"

        payload = {}
        headers = {
        'Authorization': f'Bearer BQAV4YR-U6dqqPdjhxjqGkIBnHaBnXW_hOe5OQGwNQeOF6Iz4UIM3HGdHZDO4DCEPXTiJlwYuhTuIUCuQGg',"Content_type":'application/json'
        }

        response = requests.request("GET", url, headers=headers, data = payload)
    elif int(k['compound'])<0.6 and int(k['compound'])>-0.5:
        url = f"https://api.spotify.com/v1/search?q=cheerup&type=playlist&limit=3"

        payload = {}
        headers = {
        'Authorization': f'Bearer BQAV4YR-U6dqqPdjhxjqGkIBnHaBnXW_hOe5OQGwNQeOF6Iz4UIM3HGdHZDO4DCEPXTiJlwYuhTuIUCuQGg',"Content_type":'application/json'
        }
    

        response = requests.request("GET", url, headers=headers, data = payload)
    else:
        url = f"https://api.spotify.com/v1/search?q=cheerup&type=playlist&limit=3"

        payload = {}
        headers = {
        'Authorization': f'Bearer BQAV4YR-U6dqqPdjhxjqGkIBnHaBnXW_hOe5OQGwNQeOF6Iz4UIM3HGdHZDO4DCEPXTiJlwYuhTuIUCuQGg',"Content_type":'application/json'
        }
    

        response = requests.request("GET", url, headers=headers, data = payload)


    print(ents.query)
    
    obj=Bot()
    summary=obj.final(ents.query)
    k=show_ents(ents.query)
    n=response
    return {
        "scores":analyzer.polarity_scores(ents.query),
        "ent_list":k,
        "Summary":summary,
        "Spotify":response.json()
    }




