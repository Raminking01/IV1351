CREATE TABLE instrument (
 instrument_ID INT NOT NULL,
 name VARCHAR(10) NOT NULL,
 type VARCHAR(10) NOT NULL,
 brand VARCHAR(10) NOT NULL,
 quality_in_stock INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_ID);


CREATE TABLE person (
 person_id INT NOT NULL,
 firstName VARCHAR(10) NOT NULL,
 lastName VARCHAR(10) NOT NULL,
 phone 0..* UNIQUE VARCHAR(10),
 email 0..* UNIQUE VARCHAR(30),
 age INT NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE instructor (
 instructor_ID INT NOT NULL,
 person_id INT NOT NULL,
 personNumber UNIQUE VARCHAR(10)
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_ID);


CREATE TABLE lesson (
 lesson_ID INT NOT NULL,
 scheduleDateTime  DATE WITH TIME ZONE NOT NULL,
 typeGroupOrIndividual VARCHAR(10),
 level VARCHAR(10) NOT NULL,
 instructor_ID INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_ID);


CREATE TABLE lesson_classroom (
 classroom_ID INT NOT NULL,
 capacity NOT NULL VARCHAR(10) NOT NULL,
 lesson_ID INT
);

ALTER TABLE lesson_classroom ADD CONSTRAINT PK_lesson_classroom PRIMARY KEY (classroom_ID);


CREATE TABLE student (
 student_ID INT NOT NULL,
 person_id INT NOT NULL,
 personNumber UNIQUE VARCHAR(10),
 parentPhoneNumber 0..* VARCHAR(10),
 parentEmail 0..* VARCHAR(10),
 lesson_ID INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_ID);


CREATE TABLE Address (
 address_id INT NOT NULL,
 person_id INT NOT NULL,
 classroom_ID INT,
 zip VARCHAR(10) NOT NULL,
 street VARCHAR(10) NOT NULL,
 city VARCHAR(10) NOT NULL
);

ALTER TABLE Address ADD CONSTRAINT PK_Address PRIMARY KEY (address_id);


CREATE TABLE ensemble (
 ensemble_ID CHAR(10) NOT NULL,
 instructor_ID INT NOT NULL,
 maxNumberOfStudents INT NOT NULL,
 minNumberOfStudents INT NOT NULL,
 genre VARCHAR(10) NOT NULL,
 scheduleDateTime DATE WITH TIME ZONE,
 lesson_ID INT
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (ensemble_ID);


CREATE TABLE instrument_rental (
 rental_ID INT NOT NULL,
 student_ID INT NOT NULL,
 instrument_ID INT NOT NULL,
 dateOfCharge DATE NOT NULL,
 dateOfExpiry DATE NOT NULL
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (rental_ID);


CREATE TABLE payment (
 payment_ID   NOT NULL,
 amount DECIMAL(10) NOT NULL,
 paymentType VARCHAR(10) NOT NULL,
 paymentDate DATE WITH TIME ZONE NOT NULL,
 student_ID INT NOT NULL,
 lesson_ID INT
);

ALTER TABLE payment ADD CONSTRAINT PK_payment PRIMARY KEY (payment_ID);


CREATE TABLE sibling (
 sibling_ID INT NOT NULL,
 student_ID INT
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (sibling_ID);


CREATE TABLE sibling_discount (
 discount_ID INT NOT NULL,
 discountPercentage DECIMAL(10) NOT NULL,
 startOfDiscount DATE WITH TIME ZONE NOT NULL,
 endOfDiscount DATE WITH TIME ZONE NOT NULL,
 sibling_ID INT
);

ALTER TABLE sibling_discount ADD CONSTRAINT PK_sibling_discount PRIMARY KEY (discount_ID);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_ID) REFERENCES instructor (instructor_ID);


ALTER TABLE lesson_classroom ADD CONSTRAINT FK_lesson_classroom_0 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID);


ALTER TABLE Address ADD CONSTRAINT FK_Address_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE Address ADD CONSTRAINT FK_Address_1 FOREIGN KEY (classroom_ID) REFERENCES lesson_classroom (classroom_ID);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (instructor_ID) REFERENCES instructor (instructor_ID);
ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_1 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (student_ID) REFERENCES student (student_ID);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (instrument_ID) REFERENCES instrument (instrument_ID);


ALTER TABLE payment ADD CONSTRAINT FK_payment_0 FOREIGN KEY (student_ID) REFERENCES student (student_ID);
ALTER TABLE payment ADD CONSTRAINT FK_payment_1 FOREIGN KEY (lesson_ID) REFERENCES lesson (lesson_ID);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_ID) REFERENCES student (student_ID);


ALTER TABLE sibling_discount ADD CONSTRAINT FK_sibling_discount_0 FOREIGN KEY (sibling_ID) REFERENCES sibling (sibling_ID);


