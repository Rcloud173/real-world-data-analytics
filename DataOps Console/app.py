from logging import exception

import streamlit as st
import pandas as pd
from db_functions import(
connect_to_db,
get_basic_info,
get_additonal_tables,
get_categories,
get_suppliers,
add_new_manual_id, get_all_products, get_product_history, place_reorder,
get_pending_reorders,mark_reorder_as_received
)

# sidebar
st.sidebar.title(" Inventory Management Dashboard")
option = st.sidebar.radio("Select Option:", ["Basic Information","Operational Tasks"])




