

CREATE TABLE "classes" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
"name" TEXT NOT NULL UNIQUE,
"period" TEXT,
"task_set_id" INTEGER REFERENCES "task_sets"("id") ON UPDATE CASCADE ON DELETE RESTRICT,
"notes" TEXT
);
INSERT INTO "classes" VALUES (1, 'English 11', 'Semester 2/2021', 1, NULL);
INSERT INTO "classes" VALUES (2, 'Communications 10', 'Summer 2021', 2, NULL);


CREATE TABLE "classes_students" (
"class_id" INTEGER REFERENCES "classes"("id") ON UPDATE CASCADE ON DELETE CASCADE,
"student_id" INTEGER REFERENCES "students"("") ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE "ledger" (
"id" INTEGER PRIMARY KEY ASC AUTOINCREMENT NOT NULL,
"parent_id" INTEGER,
"position" INTEGER UNIQUE NOT NULL,
"ts" TEXT NOT NULL,
"name" TEXT NOT NULL,
"data" TEXT,
"metadata" TEXT
);
INSERT INTO "ledger" VALUES (1, NULL, 1, '2021-06-08T00:00:00.000Z', 'created-student', '{:student/id 1 :student/name "Joe Smith"}', NULL);


CREATE TABLE "snapshots" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"class_id" INTEGER REFERENCES "classes"("id") NOT NULL,
"data" TEXT
);


CREATE TABLE "score_types" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT,
"name" TEXT NOT NULL,
"score" REAL,
"should_omit" INTEGER CHECK (should_omit == 0 OR should_omit == 1) DEFAULT 0
);

INSERT INTO "score_types" VALUES (1, 'On Time', NULL, 0); 
INSERT INTO "score_types" VALUES (2, 'Absent', 0.0, 0);
INSERT INTO "score_types" VALUES (3, 'Excused', NULL, 1);
INSERT INTO "score_types" VALUES (1, 'Late', NULL, 0);


CREATE TABLE "students" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
"name" TEXT UNIQUE NOT NULL,
"student_no" TEXT,
"sort_name" TEXT,
"notes" TEXT
);
INSERT INTO "students" VALUES (1, 'Basi Gallos e Rivera', NULL, 'GAL', NULL);
INSERT INTO "students" VALUES (2, 'Jilliana Davies', NULL, 'DAV', NULL);
INSERT INTO "students" VALUES (3, 'Max Horvath', NULL, 'HORV', NULL);


CREATE TABLE "students_tasks" (
"student_id" INTEGER REFERENCES "students"("id") ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
"task_id" INTEGER NOT NULL,
"score" REAL,
"score_type" INTEGER NOT NULL
);


CREATE TABLE "task_sets" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT,
"name" TEXT,
"deleted" INTEGER CHECK (deleted == 0 OR deleted == 1) DEFAULT 0
);
INSERT INTO "task_sets" VALUES (1, 'English');
INSERT INTO "task_sets" VALUES (2, 'Communications');


CREATE TABLE "task_sets_task_types" (
"task_set_id" INTEGER REFERENCES "task_sets"("id") ON UPDATE CASCADE ON DELETE CASCADE,
"task_type_id" INTEGER REFERENCES "task_types"("id") ON UPDATE CASCADE ON DELETE CASCADE,
"weighting" REAL
);
INSERT INTO "task_sets_task_types" VALUES (1, 1, 0.35);
INSERT INTO "task_sets_task_types" VALUES (1, 4, 0.65);


CREATE TABLE "task_types" (
"id" INTEGER PRIMARY KEY AUTOINCREMENT,
"name" TEXT,
"deleted" INTEGER CHECK (deleted == 0 OR deleted == 1) DEFAULT 0
);
INSERT INTO "task_types" VALUES (1, 'Quiz');
INSERT INTO "task_types" VALUES (2, 'Lab');
INSERT INTO "task_types" VALUES (3, 'Test');
INSERT INTO "task_types" VALUES (4, 'Writing');
INSERT INTO "task_types" VALUES (5, 'Class Work');


CREATE TABLE "tasks" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
"name" TEXT NOT NULL UNIQUE,
"max_score" INTEGER NOT NULL DEFAULT 100,
"scale_factor" REAL DEFAULT 1.0 NOT NULL,
"notes" TEXT,
"deleted" INTEGER CHECK (deleted == 0 OR deleted == 1) DEFAULT 0
);

INSERT INTO "tasks" VALUES (1, 'Shakespeare Quiz', 20, 1.0, NULL);
