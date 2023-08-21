
-- Query 1
SELECT
    s1.student_id,
    CASE
        WHEN COUNT(s2.student_id) IS NULL THEN 0
        ELSE COUNT(s2.student_id)
    END AS sibling_count
FROM
    public.student s1
LEFT JOIN
    public.student s2 ON s1.person_id <> s2.person_id
GROUP BY
    s1.student_id
ORDER BY
    sibling_count;

-- Query 2
SELECT
    COUNT(CASE WHEN sibling_count = 0 THEN 1 ELSE NULL END) AS no_siblings,
    COUNT(CASE WHEN sibling_count = 1 THEN 1 ELSE NULL END) AS one_sibling,
    COUNT(CASE WHEN sibling_count = 2 THEN 1 ELSE NULL END) AS two_siblings
FROM (
    SELECT
        s.student_id,
        s.personnumber,
        COUNT(sb.sibling_id) AS sibling_count
    FROM
        public.student s
    LEFT JOIN
        public.sibling sb ON s.student_id = sb.student_id
    GROUP BY
        s.student_id, s.personnumber
) AS student_siblings;

-- Query 3
WITH InstructorLessonCounts AS (
    SELECT
        i.instructor_id,
        i.person_id,
        i.personnumber,
        COUNT(*) AS lesson_count
    FROM
        public.instructor i
    JOIN
        public.lesson l ON i.instructor_id = l.instructor_id
    WHERE
        EXTRACT(YEAR FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI')) = EXTRACT(YEAR FROM CURRENT_DATE) AND
        EXTRACT(MONTH FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI')) = EXTRACT(MONTH FROM CURRENT_DATE)
    GROUP BY
        i.instructor_id, i.person_id, i.personnumber
)
SELECT
    instructor_id,
    person_id,
    personnumber,
    lesson_count
FROM
    InstructorLessonCounts
WHERE
    lesson_count > 2
ORDER BY
    lesson_count DESC;

-- Query 4

SELECT
    e.ensemble_id,
    e.genre,
    TO_CHAR(TO_DATE(e.scheduledatetime, 'YYYY-MM-DD HH12:MI AM'), 'Day') AS weekday,
    e.scheduledatetime,
    e.maxnumberofstudents,
    e.minnumberofstudents,
    CASE
        WHEN e.maxnumberofstudents = e.minnumberofstudents THEN 'Full Booked'
        WHEN e.maxnumberofstudents - COUNT(s.student_id) <= 2 THEN '1-2 Seats Left'
        ELSE 'More Seats Left'
    END AS booking_status
FROM
    public.ensemble e
LEFT JOIN
    public.lesson l ON e.lesson_id = l.lesson_id
LEFT JOIN
    public.student s ON l.lesson_id = s.lesson_id
WHERE
    TO_DATE(e.scheduledatetime, 'YYYY-MM-DD HH12:MI AM') >= CURRENT_DATE + INTERVAL '1 week'
    AND TO_DATE(e.scheduledatetime, 'YYYY-MM-DD HH12:MI AM') < CURRENT_DATE + INTERVAL '2 weeks'
GROUP BY
    e.ensemble_id, e.genre, weekday, e.scheduledatetime, e.maxnumberofstudents, e.minnumberofstudents
ORDER BY
    e.genre, weekday;
