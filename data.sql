
INSERT INTO instrument (instrument_ID, name, type, brand, quality_in_stock)
VALUES
    (1, 'Guitar', 'String', 'Fender', 10),
    (2, 'Piano', 'Keyboard', 'Yamaha', 5),
    (3, 'Flute', 'Wind', 'Jupiter', 8);

INSERT INTO lesson (lesson_ID, scheduleDateTime, typeGroupOrIndividual, level)
VALUES
    (1, '2023-08-16 10:00', 'Individual', 'Beginner'),
    (2, '2023-08-17 14:00', 'Group', 'Intermediate'),
    (3, '2023-08-18 16:30', 'Individual', 'Advanced');


INSERT INTO lesson_classroom (classroom_ID, capacity, lesson_ID)
VALUES
    (1, 10, 1),
    (2, 8, 2),
    (3, 12, 3);


INSERT INTO person (person_id, firstName, lastName, phone, email, age)
VALUES
    (1, 'John', 'Doe', '1234567890', 'john@example.com', 25),
    (2, 'Jane', 'Smith', '9876543210', 'jane@example.com', 30),
    (3, 'Michael', 'Johnson', '5551234567', 'michael@example.com', 22),
    (4, 'Emma', 'Johnson', '1234567890', 'emma.johnson@example.com', 28),
    (5, 'Liam', 'Smith', '9876543210', 'liam.smith@example.com', 31),
    (6, 'Olivia', 'Williams', '5551234567', 'olivia.williams@example.com', 22),
    (7, 'Noah', 'Brown', '9998887777', 'noah.brown@example.com', 25),
    (8, 'Sophia', 'Davis', '1112223333', 'sophia.davis@example.com', 37);


INSERT INTO student (student_ID, person_id, personNumber, parentPhoneNumber, parentEmail, lesson_ID)
VALUES
    (1, 1, 'STU123', '5559876543', 'parent1@example.com', 1),
    (2, 2, 'STU456', '5551234567', 'parent2@example.com', 2),
    (3, 3, 'STU789', '5555555555', 'parent3@example.com', 3);


INSERT INTO Address (address_id, person_id, classroom_ID, zip, street, city)
VALUES
    (1, 1, 1, '12345', '123 Main St', 'Cityville'),
    (2, 2, 2, '54321', '456 Elm St', 'Towntown'),
    (3, 3, 3, '67890', '789 Oak St', 'Villageville');


INSERT INTO ensemble (ensemble_ID, lesson_ID, instructor_ID, maxNumberOfStudents, minNumberOfStudents, genre, scheduleDateTime)
VALUES
    (1, 2, 1, 8, 4, 'Classical', '2023-08-20 15:00'),
    (2, 3, 2, 10, 5, 'Rock', '2023-08-21 17:30');


INSERT INTO instructor (instructor_ID, person_id, personNumber)
VALUES
    (1, 4, 'INST001'),
    (2, 5, 'INST002');

INSERT INTO instrument_rental (rental_ID, student_ID, instrument_ID, dateOfCharge, dateOfExpiry)
VALUES
    (1, 1, 1, '2023-08-16', '2023-09-16'),
    (2, 2, 2, '2023-08-17', '2023-09-17'),
    (3, 3, 3, '2023-08-18', '2023-09-18');

INSERT INTO payment (payment_ID, amount, paymentType, paymentDate, student_ID, lesson_ID)
VALUES
    (1, 100.00, 'Credit Card', '2023-08-16', 1, 1),
    (2, 150.00, 'Cash', '2023-08-17', 2, 2),
    (3, 120.00, 'Bank Transfer', '2023-08-18', 3, 3);


INSERT INTO sibling (sibling_ID, student_ID)
VALUES
    (1, 2),
    (2, 3);


INSERT INTO sibling_discount (discount_ID, discountPercentage, startOfDiscount, endOfDiscount, sibling_ID)
VALUES
    (1, 10.00, '2023-08-01', '2023-09-01', 1),
    (2, 15.00, '2023-08-01', '2023-09-01', 2);
