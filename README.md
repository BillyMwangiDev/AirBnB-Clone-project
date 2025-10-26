# 🏡 AirBnB Clone - Database Design Project

## 🚀 Overview

The **AirBnB Clone Backend** is designed to provide a robust and scalable foundation for managing user interactions, property listings, bookings, payments, and reviews. This repository contains the complete professional database architecture, including Entity-Relationship modeling, normalization, SQL DDL scripting, and realistic data seeding.

This project replicates the essential features of Airbnb, ensuring a smooth experience for both users and hosts through a well-designed relational database structure.

---

## 🎯 Project Goals

### Core Objectives

1. **User Management:** Secure registration, authentication, and profile handling with role-based access control
2. **Property Management:** Create, update, and manage property listings with detailed information
3. **Booking System:** Enable users to make and manage bookings with status tracking
4. **Payment Processing:** Support secure transaction handling with multiple payment methods
5. **Review System:** Allow users to rate and review properties with validation
6. **Messaging System:** Facilitate communication between users (guests and hosts)
7. **Data Optimization:** Improve performance using strategic indexing and normalization

### Learning Outcomes

By completing this project, you will master:

- **Advanced Database Design:** Entity-Relationship Diagram (ERD) creation and relationship modeling
- **Database Normalization:** Apply 1NF, 2NF, and 3NF principles to optimize data integrity
- **SQL DDL Mastery:** Create tables with proper constraints, keys, and indexes
- **Data Seeding:** Write INSERT statements to populate databases with realistic test data
- **Professional Documentation:** Technical writing, version control, and architectural decisions

---

## ⚙️ Technology Stack

### Backend Framework
**Django** - A high-level Python web framework used to build and structure the backend of the application, managing APIs, models, and core logic efficiently.

**Django REST Framework (DRF)** - Extends Django to create robust and well-documented RESTful APIs, enabling CRUD operations for users, properties, bookings, and payments.

### Query Language
**GraphQL** - A flexible query language that allows clients to request specific data from the server, improving efficiency and reducing over-fetching.

### Database
**PostgreSQL** - A powerful relational database used to store and manage user, property, and booking data securely and reliably.

### Background Processing
**Celery** - Handles asynchronous tasks such as sending notifications, processing payments, and background job execution.

**Redis** - Used for caching, session management, and as a message broker to support Celery, improving performance and responsiveness.

### DevOps
**Docker** - Provides containerization to ensure consistent development, testing, and deployment environments across different systems.

**CI/CD Pipelines** - Automate the testing, integration, and deployment processes to maintain code quality and streamline continuous delivery.

---

## 📂 Repository Structure

```
alx-airbnb-database/
│
├── README.md                          # Main project documentation (this file)
├── .gitignore                         # Git ignore rules
│
├── ERD/                               # Task 1: Entity-Relationship Diagram
│   ├── requirements.md                ✅ Detailed entity and attribute specs
│   ├── erd_text_representation.md     ✅ ASCII ERD visualization
│   ├── erd_mermaid_diagram.md         ✅ Mermaid ERD (GitHub-compatible)
│   ├── drawio_guide.md                ✅ Step-by-step Draw.io tutorial
│   ├── airbnb_erd.png                 🔲 Visual ERD diagram (to be created)
│   └── airbnb_erd.drawio              🔲 Source file for editing
│
├── normalization/                     # Task 2: Database Normalization
│   ├── normalization_analysis.md      🔲 1NF, 2NF, 3NF analysis
│   └── normalized_schema.md           🔲 Final normalized schema
│
├── database-script-0x01/              # Task 3: SQL DDL Scripts
│   ├── schema.sql                     🔲 Complete table creation script
│   └── README.md                      🔲 Script documentation
│
├── database-script-0x02/              # Task 4: Sample Data Seeding
│   ├── seed.sql                       🔲 INSERT statements for test data
│   └── README.md                      🔲 Seeding documentation
│
└── docs/                              # Project Documentation
    ├── SETUP.md                       🔲 Setup and installation guide
    ├── TESTING.md                     🔲 Testing strategies
    └── ADRs/                          # Architectural Decision Records
        ├── 001-use-uuid-primary-keys.md
        ├── 002-enum-vs-lookup-tables.md
        └── 003-indexing-strategy.md
```

---

## 🗄️ Database Design

### Entities Overview

The database consists of **6 core entities** that model the entire AirBnB platform:

#### 1. **User**
Represents both guests and hosts using the platform.

**Key Fields:**
- `user_id`: UUID (Primary Key, Indexed)
- `first_name`: VARCHAR, NOT NULL
- `last_name`: VARCHAR, NOT NULL
- `email`: VARCHAR, UNIQUE, NOT NULL (Indexed)
- `password_hash`: VARCHAR, NOT NULL
- `phone_number`: VARCHAR, NULL
- `role`: ENUM (guest, host, admin), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Relationships:**
- A user can list multiple properties (as host)
- A user can make multiple bookings (as guest)
- A user can write multiple reviews
- A user can send/receive multiple messages

---

#### 2. **Property**
Represents rental listings created by hosts.

**Key Fields:**
- `property_id`: UUID (Primary Key, Indexed)
- `host_id`: UUID (Foreign Key → User.user_id)
- `name`: VARCHAR, NOT NULL
- `description`: TEXT, NOT NULL
- `location`: VARCHAR, NOT NULL
- `pricepernight`: DECIMAL, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

**Relationships:**
- A property belongs to a user (host)
- A property can have multiple bookings
- A property can have multiple reviews

---

#### 3. **Booking**
Represents reservations made by guests for properties.

**Key Fields:**
- `booking_id`: UUID (Primary Key, Indexed)
- `property_id`: UUID (Foreign Key → Property.property_id)
- `user_id`: UUID (Foreign Key → User.user_id)
- `start_date`: DATE, NOT NULL
- `end_date`: DATE, NOT NULL
- `total_price`: DECIMAL, NOT NULL
- `status`: ENUM (pending, confirmed, canceled), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Relationships:**
- A booking belongs to a user (guest)
- A booking belongs to a property
- A booking is linked to a payment

---

#### 4. **Payment**
Records payment transactions related to bookings.

**Key Fields:**
- `payment_id`: UUID (Primary Key, Indexed)
- `booking_id`: UUID (Foreign Key → Booking.booking_id)
- `amount`: DECIMAL, NOT NULL
- `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL

**Relationships:**
- A payment belongs to a booking
- A booking has one payment (1:1 relationship)

---

#### 5. **Review**
Represents feedback provided by users about a property.

**Key Fields:**
- `review_id`: UUID (Primary Key, Indexed)
- `property_id`: UUID (Foreign Key → Property.property_id)
- `user_id`: UUID (Foreign Key → User.user_id)
- `rating`: INTEGER, NOT NULL (CHECK: rating >= 1 AND rating <= 5)
- `comment`: TEXT, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Relationships:**
- A review belongs to a user
- A review belongs to a property

---

#### 6. **Message**
Facilitates communication between users.

**Key Fields:**
- `message_id`: UUID (Primary Key, Indexed)
- `sender_id`: UUID (Foreign Key → User.user_id)
- `recipient_id`: UUID (Foreign Key → User.user_id)
- `message_body`: TEXT, NOT NULL
- `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Relationships:**
- A message has one sender (user)
- A message has one recipient (user)

---

### Entity Relationship Summary

```
USER (1) ──owns (as host)──> (N) PROPERTY
USER (1) ──makes (as guest)──> (N) BOOKING
PROPERTY (1) ──has bookings──> (N) BOOKING
BOOKING (1) ──has payment──> (1) PAYMENT
PROPERTY (1) ──receives reviews──> (N) REVIEW
USER (1) ──writes reviews──> (N) REVIEW
USER (1) ──sends messages──> (N) MESSAGE
USER (1) ──receives messages──> (N) MESSAGE
```

### Key Design Decisions

#### 1. UUID Primary Keys
**Decision:** Use UUID instead of auto-increment integers

**Rationale:**
- Globally unique identifiers
- Support for distributed systems
- No collision risk across multiple databases
- Better security (non-sequential IDs)

#### 2. ENUM Types for Status Fields
**Decision:** Use ENUM types for controlled vocabularies

**Fields:**
- `User.role`: guest, host, admin
- `Booking.status`: pending, confirmed, canceled
- `Payment.payment_method`: credit_card, paypal, stripe

**Rationale:**
- Data validation at database level
- Prevents invalid values
- Better performance than JOIN with lookup tables
- Clear domain constraints

#### 3. Timestamp Tracking
**Decision:** Include timestamps on all entities

**Implementation:**
- All entities have `created_at` for audit trail
- Property has `updated_at` for change tracking
- Automatic timestamping with `DEFAULT CURRENT_TIMESTAMP`

**Rationale:**
- Audit compliance
- Debug assistance
- Analytics and reporting
- Change tracking

#### 4. Strategic Indexing
**Decision:** Index primary keys, foreign keys, and frequently queried columns

**Indexes:**
- All primary keys (automatic)
- All foreign keys (performance)
- `User.email` (authentication lookups)
- `Booking.status` (filtering queries)

**Rationale:**
- Faster query execution
- Efficient JOIN operations
- Improved authentication performance
- Support for complex queries

---

## 🚀 Getting Started

### Prerequisites

- **Database System:** PostgreSQL 13+ or MySQL 8+
- **SQL Client:** 
  - pgAdmin (PostgreSQL)
  - MySQL Workbench
  - DBeaver (universal)
  - Command-line client
- **Diagramming Tool:** Draw.io (https://app.diagrams.net/)
- **Version Control:** Git 2.30+
- **Text Editor:** VS Code, Sublime, or similar

### Installation Steps

#### 1. Clone Repository
```bash
git clone https://github.com/your-username/alx-airbnb-database.git
cd alx-airbnb-database
```

#### 2. Create Database

**PostgreSQL:**
```sql
CREATE DATABASE airbnb_clone;
\c airbnb_clone
```

**MySQL:**
```sql
CREATE DATABASE airbnb_clone CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airbnb_clone;
```

#### 3. Run Schema Script
```bash
# PostgreSQL
psql -U your_username -d airbnb_clone -f database-script-0x01/schema.sql

# MySQL
mysql -u your_username -p airbnb_clone < database-script-0x01/schema.sql
```

#### 4. Seed Sample Data
```bash
# PostgreSQL
psql -U your_username -d airbnb_clone -f database-script-0x02/seed.sql

# MySQL
mysql -u your_username -p airbnb_clone < database-script-0x02/seed.sql
```

#### 5. Verify Installation
```sql
-- Check tables
\dt  -- PostgreSQL
SHOW TABLES;  -- MySQL

-- Count records
SELECT 'users' AS table_name, COUNT(*) FROM "User"
UNION ALL
SELECT 'properties', COUNT(*) FROM Property
UNION ALL
SELECT 'bookings', COUNT(*) FROM Booking
UNION ALL
SELECT 'payments', COUNT(*) FROM Payment
UNION ALL
SELECT 'reviews', COUNT(*) FROM Review
UNION ALL
SELECT 'messages', COUNT(*) FROM Message;
```

---

## 📋 Project Tasks

### ✅ Task 1: Entity-Relationship Diagram (ERD)
**Directory:** `ERD/`

**Objective:** Create a comprehensive visual representation of the database structure.

**Status:** Documentation Complete | Diagram Creation Pending

**Deliverables:**
- ✅ `requirements.md` - Complete entity and attribute specifications
- ✅ `erd_text_representation.md` - ASCII diagram
- ✅ `erd_mermaid_diagram.md` - Mermaid ERD (GitHub-renderable)
- ✅ `drawio_guide.md` - Step-by-step tutorial
- 🔲 `airbnb_erd.png` - Visual diagram (student task)
- 🔲 `airbnb_erd.drawio` - Source file (student task)

**Instructions:**
1. Review the complete specifications in `ERD/requirements.md`
2. Follow the step-by-step guide in `ERD/drawio_guide.md`
3. Open https://app.diagrams.net/
4. Create your ERD diagram with all 6 entities
5. Show all 8 relationships with proper cardinality
6. Export as PNG and save to `ERD/airbnb_erd.png`
7. Save source file as `ERD/airbnb_erd.drawio`

**Acceptance Criteria:**
- All 6 entities represented with attributes
- All attributes listed with data types
- Primary keys (PK) and foreign keys (FK) clearly marked
- All 8 relationships drawn with correct cardinality (1:1, 1:N)
- Professional formatting and clear layout
- Exported in high resolution

---

### 🔲 Task 2: Database Normalization
**Directory:** `normalization/`

**Objective:** Apply normalization principles to ensure data integrity and eliminate redundancy.

**Status:** Pending

**Deliverables:**
- 🔲 `normalization_analysis.md` - Step-by-step 1NF, 2NF, 3NF analysis
- 🔲 `normalized_schema.md` - Final optimized schema

**Acceptance Criteria:**
- Clear explanation of each normal form
- Identification of functional dependencies
- Documentation of normalization decisions
- Schema meets 3NF requirements
- No data redundancy
- Optimal table structure

---

### 🔲 Task 3: SQL DDL Scripts
**Directory:** `database-script-0x01/`

**Objective:** Write executable SQL scripts to create the database schema.

**Status:** Pending

**Deliverables:**
- 🔲 `schema.sql` - Complete CREATE TABLE statements
- 🔲 `README.md` - Script documentation and usage

**Acceptance Criteria:**
- All 6 tables created with correct data types
- Primary keys, foreign keys, and constraints defined
- Indexes implemented for performance
- ENUM types properly configured
- CHECK constraints for data validation
- Scripts execute without errors on both PostgreSQL and MySQL

---

### 🔲 Task 4: Sample Data Seeding
**Directory:** `database-script-0x02/`

**Objective:** Populate the database with realistic test data.

**Status:** Pending

**Deliverables:**
- 🔲 `seed.sql` - INSERT statements for all tables
- 🔲 `README.md` - Data seeding documentation

**Acceptance Criteria:**
- At least 10 users (mix of guests, hosts, and admins)
- At least 20 properties across various locations
- At least 30 bookings with different statuses
- At least 25 payments with various methods
- At least 40 reviews with varied ratings (1-5)
- At least 50 messages between users
- Data demonstrates realistic scenarios
- Referential integrity maintained (no orphaned records)

---

## 🔒 Database Security & Constraints

### Implemented Security Measures

#### 1. **Password Security**
- Never store plain text passwords
- Use `password_hash` field for bcrypt/argon2 hashes
- Application layer handles hashing before storage

#### 2. **Role-Based Access Control**
- User roles (guest, host, admin) control permissions
- Admin role for platform management
- Host role for property management
- Guest role for booking and reviews

#### 3. **Data Validation Constraints**

**User Table:**
- Unique constraint on `email`
- NOT NULL constraints on required fields
- ENUM constraint on `role`

**Property Table:**
- Foreign key constraint on `host_id`
- NOT NULL constraints on essential attributes

**Booking Table:**
- Foreign key constraints on `property_id` and `user_id`
- `status` must be one of: pending, confirmed, canceled
- Business rule: `end_date` must be after `start_date`

**Payment Table:**
- Foreign key constraint on `booking_id`
- ENUM constraint on `payment_method`
- Business rule: `amount` must be positive

**Review Table:**
- CHECK constraint on `rating` (1-5)
- Foreign key constraints on `property_id` and `user_id`

**Message Table:**
- Foreign key constraints on `sender_id` and `recipient_id`
- Business rule: `sender_id` ≠ `recipient_id`

#### 4. **Referential Integrity**
- All foreign keys enforce constraints
- Prevents orphaned records
- Maintains data consistency
- Cascade behaviors defined appropriately

#### 5. **Audit Trails**
- `created_at` timestamps on all entities
- `updated_at` on Property for change tracking
- Payment records with transaction timestamps

---

## ⚡ Performance Optimization

### Indexing Strategy

#### Automatic Indexes (Primary Keys)
- `User.user_id`
- `Property.property_id`
- `Booking.booking_id`
- `Payment.payment_id`
- `Review.review_id`
- `Message.message_id`

#### Foreign Key Indexes
- `Property.host_id` → Fast property listings by host
- `Booking.property_id` → Fast availability queries
- `Booking.user_id` → Fast user booking history
- `Payment.booking_id` → Fast payment lookups
- `Review.property_id` → Fast property reviews
- `Review.user_id` → Fast user review history
- `Message.sender_id` → Fast sent messages
- `Message.recipient_id` → Fast received messages

#### Unique Indexes
- `User.email` → Fast authentication lookups + uniqueness enforcement

#### Status Indexes
- `Booking.status` → Filter bookings by status efficiently

#### Composite Indexes (Optional Performance Boost)
- `Booking(property_id, start_date, end_date)` → Availability searches
- `Review(property_id, created_at DESC)` → Recent reviews by property

### Query Optimization Tips

1. **Use indexes effectively:**
   - Filter on indexed columns in WHERE clauses
   - Avoid functions on indexed columns

2. **Limit result sets:**
   - Use LIMIT/OFFSET for pagination
   - Apply filters early with WHERE clauses

3. **Optimize joins:**
   - Join on indexed columns (foreign keys)
   - Use appropriate join types (INNER, LEFT)
   - Avoid unnecessary joins

4. **Monitor slow queries:**
   - Enable query logging
   - Use EXPLAIN ANALYZE to identify bottlenecks
   - Add indexes based on actual query patterns

---

## 👥 Team Roles

**Backend Developer** - Develops and maintains the server-side logic, APIs, and business workflows such as listings, bookings, and payments, ensuring data accuracy and performance.

**Database Administrator (DBA)** - Designs, manages, and optimizes the PostgreSQL database, ensuring data integrity, backups, and efficient query performance.

**DevOps Engineer** - Automates deployment, testing, and monitoring processes. Manages Docker, CI/CD pipelines, and system infrastructure for scalability and reliability.

**QA Engineer** - Tests and validates backend functionality to ensure quality, stability, and performance. Detects and reports bugs before deployment.

**System Architect** - Defines the technical architecture and overall system design, ensuring scalability, modularity, and alignment with business objectives.

**Project Manager** - Oversees timelines, resources, and communication among team members. Ensures deliverables meet project goals and deadlines.

---

## 🚀 CI/CD Pipeline

Continuous Integration (CI) and Continuous Deployment (CD) pipelines automate the process of building, testing, and deploying code changes.

### Why CI/CD is Important
- Automatic testing and validation before merge
- Stable and production-ready system at all times
- Faster delivery of new features
- Reduced integration issues
- Enhanced collaboration among developers

### Tools Used
- **GitHub Actions:** Automates workflows such as testing, linting, and deployment
- **Docker:** Ensures consistency across development, testing, and production environments
- **Jenkins:** Manages complex build and deployment pipelines
- **Docker Hub / AWS / Render:** Hosts containerized applications in production

---

## 🤝 Contributing Guidelines

### Git Workflow

#### Branch Strategy
```bash
main                 # Production-ready code
└── develop          # Integration branch
    ├── feature/database-erd-design
    ├── feature/normalization
    ├── feature/sql-ddl-scripts
    └── feature/data-seeding
```

#### Creating a Feature Branch
```bash
# Checkout develop branch
git checkout develop

# Create and switch to feature branch
git checkout -b feature/your-feature-name

# Make changes and commit
git add .
git commit -m "feat(scope): descriptive message"

# Push to remote
git push origin feature/your-feature-name
```

### Commit Message Format

Follow the Conventional Commits specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Test additions/changes
- `chore`: Maintenance tasks
- `style`: Formatting changes

**Examples:**
```bash
feat(schema): add User and Property tables

- Create User table with UUID primary key
- Create Property table with foreign key to User
- Add appropriate indexes and constraints

Refs: #123
```

```bash
docs(erd): add comprehensive ERD requirements

- Document all 6 entities with attributes
- Define 8 relationships with cardinality
- Include indexing strategy
- Add Draw.io creation guide
```

```bash
fix(seed): correct foreign key references in sample data

- Fix property_id references in Booking table
- Ensure all user_ids exist in User table
- Validate payment_method ENUM values
```

### Pull Request Process
1. Create feature branch from `develop`
2. Make changes with clear, atomic commits
3. Update relevant documentation
4. Test your changes thoroughly
5. Submit PR with detailed description
6. Request peer review
7. Address feedback promptly
8. Merge after approval

---

## ✅ Project Checklist

### Setup Phase
- [x] Repository created and initialized
- [x] Directory structure established
- [x] README documentation written
- [x] Git initialized with feature branch
- [x] Database schema saved to memory

### Task 1: ERD (Current Focus)
- [x] Requirements documented (`ERD/requirements.md`)
- [x] Text-based ERD created (`ERD/erd_text_representation.md`)
- [x] Mermaid diagram provided (`ERD/erd_mermaid_diagram.md`)
- [x] Draw.io guide written (`ERD/drawio_guide.md`)
- [ ] Visual ERD created (`ERD/airbnb_erd.png`) - **Your task**
- [ ] Source file saved (`ERD/airbnb_erd.drawio`) - **Your task**

### Task 2: Normalization
- [ ] 1NF analysis completed
- [ ] 2NF analysis completed
- [ ] 3NF analysis completed
- [ ] Final normalized schema documented

### Task 3: SQL DDL
- [ ] schema.sql created
- [ ] All 6 tables defined
- [ ] Constraints implemented
- [ ] Indexes added
- [ ] Script tested on PostgreSQL
- [ ] Script tested on MySQL

### Task 4: Data Seeding
- [ ] seed.sql created
- [ ] Sample users inserted (10+)
- [ ] Sample properties inserted (20+)
- [ ] Sample bookings inserted (30+)
- [ ] Sample payments inserted (25+)
- [ ] Sample reviews inserted (40+)
- [ ] Sample messages inserted (50+)
- [ ] Data validated for integrity

### Documentation
- [x] Main README completed
- [ ] Setup guide created (`docs/SETUP.md`)
- [ ] Testing guide created (`docs/TESTING.md`)
- [ ] ADRs documented (`docs/ADRs/`)
- [ ] All directory READMEs completed

---

## 📚 Learning Resources

### Database Design
- [Database Design Tutorial](https://www.lucidchart.com/pages/database-diagram/database-design)
- [ER Diagram Symbols and Notation](https://www.smartdraw.com/entity-relationship-diagram/)
- [Normalization Explained](https://www.studytonight.com/dbms/database-normalization.php)
- [Database Normalization - 1NF, 2NF, 3NF](https://www.guru99.com/database-normalization.html)

### SQL Best Practices
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [SQL Style Guide](https://www.sqlstyle.guide/)
- [Use The Index, Luke](https://use-the-index-luke.com/) - SQL Indexing Guide

### Professional Development
- [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)
- [Database Internals](https://www.databass.dev/)
- [Designing Data-Intensive Applications](https://dataintensive.net/)

---

## 📧 Contact and Support

**Author:** Billy Mwangi  
**Repository:** https://github.com/your-username/alx-airbnb-database  
**Issues:** https://github.com/your-username/alx-airbnb-database/issues  

For questions, suggestions, or contributions:
1. Check existing documentation in `ERD/` and `docs/`
2. Search closed issues for similar questions
3. Open a new issue with detailed description
4. Use appropriate labels (bug, enhancement, question)

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 Acknowledgments

- **ALX Africa** for project specifications and guidance
- **Database Design Community** for best practices and resources
- **Open-Source Community** for tools (Draw.io, PostgreSQL, MySQL)
- **Contributors** who help improve this project

---

**Last Updated:** October 26, 2025  
**Version:** 1.0.0  
**Status:** Task 1 (ERD) - Documentation Complete, Diagram Creation Pending  
**Current Branch:** `feature/database-erd-design`
