import pandas as pd
import numpy as np
import mysql.connector

def connect_to_db():
    
    return mysql.connector.connect(
    host = "localhost"
    user = "root"
    password = "amiramir123#"
    database = "data_ops"
)