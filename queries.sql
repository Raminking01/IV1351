
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
    EXTRACT(YEAR FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI')) AS year,
    EXTRACT(MONTH FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI')) AS month,
    COUNT(*) AS total_lessons,
    SUM(CASE WHEN l.typegrouporindividual = 'Individual' THEN 1 ELSE 0 END) AS individual_lessons,
    SUM(CASE WHEN l.typegrouporindividual = 'Group' THEN 1 ELSE 0 END) AS group_lessons,
    SUM(CASE WHEN l.typegrouporindividual = 'Ensemble' THEN 1 ELSE 0 END) AS ensemble_lessons
FROM
    public.lesson l
WHERE
    EXTRACT(YEAR FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI')) = 2023
GROUP BY
    EXTRACT(YEAR FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI')),
    EXTRACT(MONTH FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI'))
ORDER BY
    EXTRACT(YEAR FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI')),
    EXTRACT(MONTH FROM TO_DATE(l.scheduledatetime, 'YYYY-MM-DD HH24:MI'));

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
