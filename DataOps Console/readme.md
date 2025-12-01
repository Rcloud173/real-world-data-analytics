# 🗂️ DataOps Console: Streamlit UI for Advanced MySQL Operations

## 📘 Project Vision
**DataOps Console** is a practical, internal-style application built to bridge the gap between  
**complex SQL operations** and **non-technical business users**.

Using a **Streamlit front-end** connected to a **MySQL back-end**, the system exposes  
**stored procedures, views, and functions** through a clean button-based interface.  
This makes it possible to perform critical inventory and operational tasks **without writing SQL**.

The project simulates what real companies use to manage their daily operations—  
from stock updates to order processing to inventory monitoring.

---

## 🧬 What the System Covers
This project provides a **complete operational flow** combining database logic and UI interaction.

| Category | Functionality |
|---------|---------------|
| **Database Layer** | Tables, Views, Stored Procedures, Functions |
| **Inventory Logic** | Stock Movements, Order Processing, Restock Logic |
| **Frontend Actions** | Add Products, Create Orders, Receive Orders, View Reports |
| **User Experience** | SQL-free operations for managers & operational staff |

---

## 🎯 Core Objectives

### 1. Backend Architecture (MySQL)
- Implement **normalized tables** for products, stock movements, and orders  
- Build **stored procedures** for secure transactional operations  
- Implement **deterministic functions** for stock calculations  
- Provide **views** for instant reporting (dashboard-ready)  
- Design a schema that mirrors **real operational systems**

### 2. Frontend Interface (Streamlit)
- Visualize **inventory levels and restock status**  
- Trigger **stored procedures** with a button click  
- Add & update records through **forms and input fields**  
- Provide a **smooth experience** for non-technical users  
- Avoid exposing direct SQL queries to end-users  

---

## 🧠 Insight Extraction & Documentation
For each major database feature, the project ensures:

- **Clean separation** between logic and UI  
- Database operations are **secure, atomic, and consistent**  
- Real-world business use-cases are demonstrated:
  - Stock movement logging  
  - Order placement & fulfillment  
  - Restock detection logic  
  - Automatic inventory updates via stored procedures  
- Clear documentation for every component  
- Code structured to be reused for **future enterprise apps**

---

## 🛠️ Technical Stack

| Component | Technology |
|------------|-------------|
| **Frontend / UI** | Python, Streamlit |
| **Database** | MySQL |
| **ORM / Connectivity** | `mysql-connector-python` |
| **Configuration** | `.env` (dotenv) |
| **Deployment** | Local / Internal Dashboard |
| **Documentation** | Markdown, Comments, Modular SQL Scripts |

---

## ⚖️ Ethical Considerations

- No user-sensitive data is stored

- Designed for simulation, learning, and portfolio use

- Proper separation of DB credentials and app logic

- Follows good practices for SQL safety and data handling

---

## 🚀 Future Directions

- Role-based access control (Admin / Manager)

- Editable product & order workflows

- Analytics dashboard (restock forecast, order trendlines)

- Migration to PostgreSQL or SQLAlchemy ORM

- Deploying as an internal corporate tool

---

## 🧾 License
This project is licensed under the **MIT License** — free to use, modify, and share with appropriate attribution.

---

## 👥 Contributors
**Project Lead:** *Rcloud173*  
**Domain:** Data Science • Health Analytics • Global Epidemiology  
**Contact:** amirshaikh17543@gmail.com

---

> *"Making database power accessible; turning SQL logic into tools that anyone can use."