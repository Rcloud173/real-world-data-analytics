import pandas as pd
import numpy as np
import mysql.connector

conn = mysql.connector.connect(
    host = "localhost"
    user = "root"
    password = "amiramir123#"
    database = "data_ops"
)