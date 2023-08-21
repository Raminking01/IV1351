CREATE TABLE instrument (
 instrument_ID INT NOT NULL,
 name VARCHAR(50) NOT NULL,
 type VARCHAR(50) NOT NULL,
 brand VARCHAR(50) NOT NULL,
 quality_in_stock INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_ID);


CREATE TABLE person (
 person_id INT NOT NULL,
 firstName VARCHAR(50) NOT NULL,
 lastName VARCHAR(50) NOT NULL,
 phone VARCHAR(15) UNIQUE,
 email VARCHAR(100) UNIQUE,
 age INT NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE instructor (
 instructor_ID INT NOT NULL,
 person_id INT NOT NULL,
 personNumber VARCHAR(10) UNIQUE,
 FOREIGN KEY (person_id) REFERENCES person (person_id)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_ID);


CREATE TABLE lesson (
 lesson_ID INT NOT NULL,
 scheduleDateTime TIMESTAMP WITH TIME ZONE NOT NULL,
 typeGroupOrIndividual VARCHAR(20),
 level VARCHAR(20) NOT NULL,
 instructor_ID INT,
 FOREIGN KEY (instructor_ID) REFERENCES instructor (instructor_ID)
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_ID);


CREATE TABLE lesson_classroom (
 classroom_ID INT NOT NULL,
 capacity INT NOT NULL,
 lesson_ID INT,
 PRIMARY KEY (classroom_ID),
 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID)
);


CREATE TABLE student (
 student_ID INT NOT NULL,
 person_id INT NOT NULL,
 personNumber VARCHAR(10) UNIQUE,
 parentPhoneNumber VARCHAR(15),
 parentEmail VARCHAR(100),
 lesson_ID INT,
 PRIMARY KEY (student_ID),
 FOREIGN KEY (person_id) REFERENCES person (person_id),
 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID)
);


CREATE TABLE Address (
 address_id INT NOT NULL,
 person_id INT NOT NULL,
 classroom_ID INT,
 zip VARCHAR(10) NOT NULL,
 street VARCHAR(100) NOT NULL,
 city VARCHAR(50) NOT NULL,
 PRIMARY KEY (address_id),
 FOREIGN KEY (person_id) REFERENCES person (person_id),
 FOREIGN KEY (classroom_ID) REFERENCES lesson_classroom (classroom_ID)
);


CREATE TABLE ensemble (
 ensemble_ID VARCHAR(10) NOT NULL,
 lesson_ID INT,
 instructor_ID INT,
 maxNumberOfStudents INT NOT NULL,
 minNumberOfStudents INT NOT NULL,
 genre VARCHAR(20) NOT NULL,
 scheduleDateTime TIMESTAMP WITH TIME ZONE,
 PRIMARY KEY (ensemble_ID),
 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID),
 FOREIGN KEY (instructor_ID) REFERENCES instructor (instructor_ID)
);


CREATE TABLE instrument_rental (
 rental_ID INT NOT NULL,
 student_ID INT NOT NULL,
 instrument_ID INT NOT NULL,
 dateOfCharge DATE NOT NULL,
 dateOfExpiry DATE NOT NULL,
 PRIMARY KEY (rental_ID),
 FOREIGN KEY (student_ID) REFERENCES student (student_ID),
 FOREIGN KEY (instrument_ID) REFERENCES instrument (instrument_ID)
);


CREATE TABLE payment (
 payment_ID INT NOT NULL,
 amount DECIMAL(10, 2) NOT NULL,
 paymentType VARCHAR(20) NOT NULL,
 paymentDate DATE NOT NULL,
 student_ID INT NOT NULL,
 lesson_ID INT,
 PRIMARY KEY (payment_ID),
 FOREIGN KEY (student_ID) REFERENCES student (student_ID),
 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID)
);


CREATE TABLE sibling (
 sibling_ID INT NOT NULL,
 student_ID INT,
 PRIMARY KEY (sibling_ID),
 FOREIGN KEY (student_ID) REFERENCES student (student_ID)
);


CREATE TABLE sibling_discount (
 discount_ID INT NOT NULL,
 discountPercentage DECIMAL(5, 2) NOT NULL,
 startOfDiscount DATE NOT NULL,
 endOfDiscount DATE NOT NULL,
 sibling_ID INT,
 PRIMARY KEY (discount_ID),
 FOREIGN KEY (sibling_ID) REFERENCES sibling (sibling_ID)
);
