from django.db import models

# Create your models here.

# we will setup mongodb
from pymongo import MongoClient

# make sure to store password and username elsewhere during production
username = "abdullah"
password = "d50pmHXKs7hl0AUe"
connection_string = f"mongodb+srv://{username}:{password}@ecommerce-cluster.q4z9cse.mongodb.net/?retryWrites=true&w=majority&appName=ecommerce-cluster"

ecommerce_cluster = MongoClient(connection_string)

ecommerce_database = ecommerce_cluster["ecommerce-db"]

user_doc_collection = ecommerce_database["user_documents"]
products_collection = ecommerce_database["dummy_products"]
orders_collection = ecommerce_database["orders"]
homeContent_collection = ecommerce_database["HomePage"]
slots_collection = ecommerce_database["slots"]