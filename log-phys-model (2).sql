CREATE TABLE discount (
 id INT NOT NULL,
 percentage INT,
 requirement VARCHAR(500)
);

ALTER TABLE discount ADD CONSTRAINT PK_discount PRIMARY KEY (id);


CREATE TABLE instrument (
 identifier UNIQUE VARCHAR(500) NOT NULL
);


CREATE TABLE instrument_description (
 type VARCHAR(100),
 brand VARCHAR(100),
 quantity_in_stock INT
);


CREATE TABLE lease (
 date_of_charge TIMESTAMP(6) NOT NULL,
 date_of_expiry TIMESTAMP(6) NOT NULL
);


CREATE TABLE mail (
 mail UNIQUE VARCHAR(250) NOT NULL
);


CREATE TABLE person (
 id INT NOT NULL,
 first_name VARCHAR(250),
 last_name VARCHAR(250),
 street VARCHAR(250),
 zip VARCHAR(100),
 city VARCHAR(100)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE phone (
 phone_number UNIQUE VARCHAR(250) NOT NULL
);


CREATE TABLE student (
 id INT NOT NULL,
 person_id INT NOT NULL,
 person_number UNIQUE VARCHAR(12),
 age VARCHAR(3)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_payment (
 id INT NOT NULL,
 discount_id INT,
 date_of_charge TIMESTAMP(6) NOT NULL,
 payment_of_lessons DOUBLE PRECISION,
 payment_of_rental DOUBLE PRECISION
);

ALTER TABLE student_payment ADD CONSTRAINT PK_student_payment PRIMARY KEY (id);


CREATE TABLE instructor (
 id INT NOT NULL,
 person_id INT NOT NULL,
 person_number UNIQUE VARCHAR(12),
 age VARCHAR(3)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instructor_payment (
 id INT NOT NULL,
 instructor_id INT NOT NULL,
 payment_for_lessons_given DOUBLE PRECISION
);

ALTER TABLE instructor_payment ADD CONSTRAINT PK_instructor_payment PRIMARY KEY (id);


CREATE TABLE lesson (
 instructor_id INT NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL,
 place VARCHAR(250)
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (instructor_id,date_and_time);


CREATE TABLE parent (
 id INT NOT NULL
);

ALTER TABLE parent ADD CONSTRAINT PK_parent PRIMARY KEY (id);


CREATE TABLE skill (
 id INT NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 level VARCHAR(100)
);

ALTER TABLE skill ADD CONSTRAINT PK_skill PRIMARY KEY (id,instrument);


CREATE TABLE time_slot (
 instructor_id INT NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL
);

ALTER TABLE time_slot ADD CONSTRAINT PK_time_slot PRIMARY KEY (instructor_id,date_and_time);


CREATE TABLE ensemble (
 instructor_id INT NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL,
 genre VARCHAR(100),
 max_number_of_students INT,
 min_number_of_students INT
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (instructor_id,date_and_time);


CREATE TABLE group_lesson (
 instructor_id INT NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL,
 instrument VARCHAR(100),
 level VARCHAR(100),
 max_number_of_students INT,
 min_number_of_students INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (instructor_id,date_and_time);


CREATE TABLE individual_lesson (
 instructor_id INT NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL,
 instrument VARCHAR(100),
 level VARCHAR(100)
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (instructor_id,date_and_time);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_0 FOREIGN KEY (discount_id) REFERENCES discount (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE parent ADD CONSTRAINT FK_parent_0 FOREIGN KEY (id) REFERENCES person (id);


ALTER TABLE skill ADD CONSTRAINT FK_skill_0 FOREIGN KEY (id) REFERENCES student (id);


ALTER TABLE time_slot ADD CONSTRAINT FK_time_slot_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (instructor_id,date_and_time) REFERENCES lesson (instructor_id,date_and_time);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (instructor_id,date_and_time) REFERENCES lesson (instructor_id,date_and_time);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (instructor_id,date_and_time) REFERENCES lesson (instructor_id,date_and_time);


