# 🍽️ Restaurant Management System

A PostgreSQL-based **Restaurant Management System Database** designed to manage restaurant operations such as customer management, employee management, table allocation, menu management, order processing, billing, inventory management, supplier management, and daily kitchen preparation.

This repository contains the **complete database implementation** of the project developed using PostgreSQL.

---

# 📖 Project Overview

The Restaurant Management System is designed following proper database design principles to ensure data integrity, consistency, and efficient query performance.

The project demonstrates the implementation of a relational database from requirement analysis to testing using PostgreSQL.

The database includes:

- Requirement Analysis
- Entity Relationship (ER) Diagram
- Relational Schema
- Normalization (up to BCNF)
- Physical Database Design
- Database Implementation
- Seed Data
- Functional Testing
- Validation Testing

---

# ✨ Features

- Customer Management
- Employee Management
- Restaurant Table Management
- Menu & Category Management
- Daily Dish Preparation
- Order Management
- Billing Management
- Raw Material Inventory
- Supplier Management
- Purchase Management
- Recipe Management
- Dashboard & Reporting Views

---

# 🛠️ Technologies Used

### Database

- PostgreSQL
- SQL
- pgAdmin 4

### Documentation

- Markdown
- dbdiagram.io

---

# 📂 Project Structure

```text
Restaurant_Management/
│
├── database/
│   ├── 01_ddl/
│   │   ├── create_database.sql
│   │   └── create_tables.sql
│   │
│   ├── 02_indexes/
│   │   └── create_indexes.sql
│   │
│   ├── 03_views/
│   │   └── create_views.sql
│   │
│   ├── 04_triggers/
│   │   └── create_triggers.sql
│   │
│   ├── 05_functions/
│   │   └── create_functions.sql
│   │
│   ├── 06_procedures/
│   │   └── create_procedures.sql
│   │
│   ├── 07_seed_data/
│   │   └── seed_data.sql
│   │
│   ├── 08_testing/
│   │   ├── test_queries.sql
│   │   └── validation_queries.sql
│   │
│   └── 09_cleanup/
│       └── cleanup.sql
│
├── Documentation/
│
├── .gitignore
└── README.md
```

---

# 🗄️ Database Design

The database consists of **15 relational tables** organized into different categories.

### Master Tables

- Customer
- Employee
- Restaurant_Table
- Category
- Dish
- Raw_Material
- Supplier

### Transaction Tables

- Orders
- Bill
- Purchase

### Weak Entity

- Daily_Dish_Preparation

### Junction Tables

- Dish_Recipe
- Supplier_Raw_Material
- Order_Item
- Purchase_Item

---

# 📌 Database Features

The project demonstrates the implementation of several advanced PostgreSQL concepts, including:

- Relational Database Design
- Normalization (up to BCNF)
- Primary Keys
- Foreign Keys
- Domains
- Constraints
- Identity Columns
- Indexes
- Database Views
- Triggers
- User Defined Functions
- Stored Procedures
- Seed Data
- Functional Testing
- Validation Queries

---

# ⚙️ PostgreSQL Concepts Implemented

### Database Design

- Entity Relationship Modeling
- Relational Schema Design
- Database Normalization

### Constraints

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- CHECK
- DEFAULT
- ON DELETE
- ON UPDATE
- Custom Domains

### Performance Optimization

- B-Tree Indexes

### Database Programming

- Views
- Trigger Functions
- Triggers
- User Defined Functions
- Stored Procedures

---

# 🚀 Database Setup

## Prerequisites

- PostgreSQL
- pgAdmin 4 (Recommended)

---

Run the SQL files in the following order.

| Step | SQL File |
|------|----------|
| 1 | `01_ddl/create_database.sql` |
| 2 | Connect to the created database |
| 3 | `01_ddl/create_tables.sql` |
| 4 | `02_indexes/create_indexes.sql` |
| 5 | `03_views/create_views.sql` |
| 6 | `04_triggers/create_triggers.sql` |
| 7 | `05_functions/create_functions.sql` |
| 8 | `06_procedures/create_procedures.sql` |
| 9 | `07_seed_data/seed_data.sql` |
| 10 | `08_testing/test_queries.sql` |
| 11 | `08_testing/validation_queries.sql` |

---

# 🧪 Testing

The project includes comprehensive testing for all implemented database components.

### Functional Testing

- Table Verification
- Relationship Verification
- View Testing
- Function Testing
- Stored Procedure Testing
- Trigger Testing

### Validation Testing

- Primary Key Constraints
- Foreign Key Constraints
- CHECK Constraints
- UNIQUE Constraints
- Domain Validation
- Business Rule Validation

### Performance Testing

- Index Verification
- Query Performance Analysis
- EXPLAIN ANALYZE

---

# 📚 Documentation

The `Documentation` folder contains the database design documents, including:

- Requirement Analysis
- Entity Relationship Diagram
- Relational Schema
- Normalization
- Database Design Notes

---

# 🎯 Learning Outcomes

This project demonstrates practical implementation of:

- Database Design
- SQL Programming
- PostgreSQL
- Data Integrity
- Query Optimization
- Inventory Management
- Business Rule Enforcement
- Database Programming using PL/pgSQL

---

# 👨‍💻 Author

**Harshil Narola**

GitHub: https://github.com/HarshilNarola


---

# ⭐ Repository Status

**Current Version:** Database Module (PostgreSQL)

The repository currently contains the complete database implementation of the Restaurant Management System, including schema design, database programming, seed data, and testing.