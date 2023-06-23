PGDMP     1                    {            tests    15.1    15.1 G    l           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            m           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            n           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            o           1262    16487    tests    DATABASE     y   CREATE DATABASE tests WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE tests;
                postgres    false            p           0    0    DATABASE tests    COMMENT     K   COMMENT ON DATABASE tests IS 'default administrative connection database';
                   postgres    false    3439                        2615    16557    tst    SCHEMA        CREATE SCHEMA tst;
    DROP SCHEMA tst;
                postgres    false            q           0    0 
   SCHEMA tst    ACL     8  GRANT USAGE ON SCHEMA tst TO admins;
GRANT USAGE ON SCHEMA tst TO users;
GRANT USAGE ON SCHEMA tst TO for_read;
GRANT USAGE ON SCHEMA tst TO for_insert;
GRANT USAGE ON SCHEMA tst TO for_update;
GRANT USAGE ON SCHEMA tst TO for_del;
GRANT USAGE ON SCHEMA tst TO small_user;
GRANT USAGE ON SCHEMA tst TO managers;
                   postgres    false    6            �            1255    17071    add_user(text, text, text) 	   PROCEDURE     �  CREATE PROCEDURE tst.add_user(IN mail text, IN pass text, IN login text)
    LANGUAGE plpgsql
    AS $$
DECLARE
id_user INT;
	BEGIN
		IF ((SELECT COUNT("id пользователя") FROM tst."Пользователь") > 0) THEN
			id_user = (SELECT MAX("id пользователя") FROM tst."Пользователь") + 1;
		ELSE
			id_user = 1;
		END IF;
		
		IF mail IN (SELECT "почта" FROM tst."Пользователь") THEN
			pass:= '0';
		ELSE
			INSERT INTO tst."Пользователь"
			("id пользователя", "почта", "пароль", "имя")
			VALUES(id_user, mail, pass, login);
		END IF;
		
	END;
$$;
 H   DROP PROCEDURE tst.add_user(IN mail text, IN pass text, IN login text);
       tst          postgres    false    6            �            1255    17072    add_user_func(text, text, text)    FUNCTION     �  CREATE FUNCTION tst.add_user_func(mail text, pass text, login text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
id_user INT;
	BEGIN
		IF ((SELECT COUNT("id пользователя") FROM tst."Пользователь") > 0) THEN
			id_user = (SELECT MAX("id пользователя") FROM tst."Пользователь") + 1;
		ELSE
			id_user = 1;
		END IF;
		
		IF mail IN (SELECT "почта" FROM tst."Пользователь") THEN
			RETURN 0;
		ELSE
			INSERT INTO tst."Пользователь"
			("id пользователя", "почта", "пароль", "имя")
			VALUES(id_user, mail, pass, login);
			RETURN 1;
		END IF;
		
	END;
$$;
 C   DROP FUNCTION tst.add_user_func(mail text, pass text, login text);
       tst          postgres    false    6            �            1255    17009    count_right(integer)    FUNCTION     �  CREATE FUNCTION tst.count_right(id_user integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
id_task INTEGER ARRAY;
DECLARE
answers INTEGER ARRAY;
DECLARE 
n INTEGER; 
DECLARE 
right_and_wrong INTEGER ARRAY;
DECLARE
var INTEGER;
DECLARE
counter INTEGER;
BEGIN
	counter = 0;
	n = (SELECT COUNT("id задания") 
		 FROM "tst"."Расчёт результата"
		 WHERE "id пользователя" = id_user);
		 
	id_task = 
	(SELECT array_agg("id задания")
	FROM "tst"."Расчёт результата"
	WHERE "id пользователя" = id_user
	);

	answers = 
	(SELECT array_agg("Ответ")
	FROM "tst"."Расчёт результата"
	WHERE "id пользователя" = id_user
	);	
	FOR j IN 0..n LOOP
		var = (
		SELECT "Правильный ответ"
		FROM "tst"."Задания"
		WHERE "id задания" = id_task[j]
		);

		IF var = answers[j] THEN
			counter = counter + 1;
		END IF;

	END LOOP;
	RETURN counter;
END;
$$;
 0   DROP FUNCTION tst.count_right(id_user integer);
       tst          postgres    false    6            �            1255    17010    count_right(integer, integer)    FUNCTION     �  CREATE FUNCTION tst.count_right(id_user integer, id_test integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
id_task INTEGER ARRAY;
DECLARE
answers INTEGER ARRAY;
DECLARE 
n INTEGER; 
DECLARE 
right_and_wrong INTEGER ARRAY;
DECLARE
var INTEGER;
DECLARE
counter INTEGER;
BEGIN
	counter = 0;
	n = (SELECT COUNT("id задания") 
		 FROM "tst"."Расчёт результата"
		 WHERE "id пользователя" = id_user);
		 
	id_task = 
	(SELECT array_agg("id задания")
	FROM "tst"."Расчёт результата"
	WHERE "id пользователя" = id_user 
	and "id задания" in (SELECT "id задания" FROM "tst"."Задания" WHERE "id теста" = id_test)
	);

	answers = 
	(SELECT array_agg("Ответ")
	FROM "tst"."Расчёт результата"
	WHERE "id пользователя" = id_user
	and "id задания" in (SELECT "id задания" FROM "tst"."Задания" WHERE "id теста" = id_test)
	);	
	FOR j IN 0..n LOOP
		var = (
		SELECT "Правильный ответ"
		FROM "tst"."Задания"
		WHERE "id задания" = id_task[j]
		);

		IF var = answers[j] THEN
			counter = counter + 1;
		END IF;

	END LOOP;
	RETURN counter;
END;
$$;
 A   DROP FUNCTION tst.count_right(id_user integer, id_test integer);
       tst          postgres    false    6            �            1255    17019 
   del_task()    FUNCTION     f  CREATE FUNCTION tst.del_task() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
mark INTEGER;
BEGIN
mark = (SELECT "макс бал" FROM "tst"."tests"
		WHERE "id теста" = OLD."id теста") - OLD."Вклад в баллах";
UPDATE "tst"."tests"
SET "макс бал" = mark
WHERE "id теста" = OLD."id теста";
RETURN OLD;
END;
$$;
    DROP FUNCTION tst.del_task();
       tst          postgres    false    6            �            1255    16995 	   ins_del() 	   PROCEDURE     �   CREATE PROCEDURE tst.ins_del()
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO python ("Задание", "id темы")
		VALUES('asd', 1);
		DELETE FROM python
		WHERE "Задание" = 'asd';
	END;
$$;
    DROP PROCEDURE tst.ins_del();
       tst          postgres    false    6            �            1255    17011 	   ins_res()    FUNCTION     O	  CREATE FUNCTION tst.ins_res() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
tests INTEGER;
DECLARE
users INTEGER;
DECLARE 
last_res INTEGER;
DECLARE 
answer INTEGER;
DECLARE 
duration INTERVAL;
DECLARE 
_session INTEGER;
BEGIN
_session = (SELECT "id сессии" FROM "tst"."Расчёт результата");
duration = (SELECT "Время конца" FROM "tst"."Сессии" WHERE "id сессии" = _session) -
(SELECT "Время начала" FROM "tst"."Сессии" WHERE "id сессии" = _session);

last_res = (SELECT MAX("id результата") FROM "tst"."Результаты пользователей");
IF last_res IS NULL THEN
	last_res = 0;
END IF;
last_res = last_res + 1;

tests = (SELECT "id теста" FROM "tst"."Задания" WHERE 
		 "id задания" IN (SELECT "id задания" FROM "tst"."Расчёт результата")
		 LIMIT 1);
		 
users = (SELECT "id пользователя" FROM "tst"."Расчёт результата" LIMIT 1);

answer = (SELECT "Правильный ответ" FROM "tst"."Задания" WHERE 
		 "id задания" IN (SELECT "id задания" FROM "tst"."Расчёт результата")
		 LIMIT 1);

IF _session IN (SELECT "id сессии" FROM "tst"."Результаты пользователей") THEN
	-- Не создавать сессиию в результатах и добавить длительность
	IF tests IN 
		(SELECT "id теста" FROM "tst"."Результаты пользователей"
		WHERE users = "id пользователя") THEN
		UPDATE "tst"."Результаты пользователей"
			SET "Результат" =  "Результат" + 
			(SELECT "tst".count_right(users, tests))
			WHERE "id теста" = tests AND "id пользователя" = users
			AND "id сессии" = _session; 
	ELSE
		INSERT INTO "tst"."Результаты пользователей"
			VALUES (last_res, users, tests,
					(SELECT "tst".count_right(users, tests)), _session,
				   	duration);
			last_res = last_res + 1;
	END IF;
	
ELSE
	INSERT INTO "tst"."Результаты пользователей"
			VALUES (last_res, users, tests,
					(SELECT "tst".count_right(users, tests)), _session,
				   	duration);
			last_res = last_res + 1;
END IF;
DELETE FROM "tst"."Расчёт результата";
RETURN NULL;

END;
$$;
    DROP FUNCTION tst.ins_res();
       tst          postgres    false    6            �            1255    16997    insert_python(text) 	   PROCEDURE     �   CREATE PROCEDURE tst.insert_python(IN what_insert text)
    LANGUAGE plpgsql
    AS $$
	BEGIN
		INSERT INTO python
		("Задание", "id темы")
		VALUES(what_insert, 1);
	END;
$$;
 7   DROP PROCEDURE tst.insert_python(IN what_insert text);
       tst          postgres    false    6            �            1259    16564    Задания    TABLE     4  CREATE TABLE tst."Задания" (
    "id задания" bigint DEFAULT '-1'::integer NOT NULL,
    "Задание" character varying(1000),
    "Вклад в баллах" bigint DEFAULT 1,
    "id теста" bigint DEFAULT 1,
    "Правильный ответ" bigint,
    "id темы" bigint
);
 !   DROP TABLE tst."Задания";
       tst         heap    postgres    false    6            r           0    0    TABLE "Задания"    COMMENT     o   COMMENT ON TABLE tst."Задания" IS 'Задания из которых собираются тесты';
          tst          postgres    false    216            s           0    0    TABLE "Задания"    ACL     �  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst."Задания" TO admins;
GRANT SELECT ON TABLE tst."Задания" TO users;
GRANT SELECT ON TABLE tst."Задания" TO for_read;
GRANT INSERT ON TABLE tst."Задания" TO for_insert;
GRANT UPDATE ON TABLE tst."Задания" TO for_update;
GRANT DELETE ON TABLE tst."Задания" TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst."Задания" TO managers;
          tst          postgres    false    216            �            1259    16710 
   count_task    VIEW     �   CREATE VIEW public.count_task AS
 SELECT "Задания"."id темы",
    count("Задания"."id задания") AS count
   FROM tst."Задания"
  GROUP BY "Задания"."id темы";
    DROP VIEW public.count_task;
       public          postgres    false    216    216            �            1259    16718    python    VIEW     �   CREATE VIEW public.python AS
 SELECT "Задания"."Задание",
    "Задания"."id темы"
   FROM tst."Задания"
  WHERE ("Задания"."id темы" = 1);
    DROP VIEW public.python;
       public          postgres    false    216    216            �            1259    16558    tests    TABLE     �   CREATE TABLE tst.tests (
    "id теста" bigint DEFAULT 0 NOT NULL,
    "макс бал" bigint DEFAULT '-1'::integer,
    "сложность теста" bigint DEFAULT 0,
    "Длительность теста" interval
);
    DROP TABLE tst.tests;
       tst         heap    postgres    false    6            t           0    0    TABLE tests    COMMENT     X   COMMENT ON TABLE tst.tests IS 'Список тестов с их сложностью';
          tst          postgres    false    215            u           0    0    TABLE tests    ACL     \  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst.tests TO admins;
GRANT SELECT ON TABLE tst.tests TO users;
GRANT SELECT ON TABLE tst.tests TO for_read;
GRANT INSERT ON TABLE tst.tests TO for_insert;
GRANT UPDATE ON TABLE tst.tests TO for_update;
GRANT DELETE ON TABLE tst.tests TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst.tests TO managers;
          tst          postgres    false    215            �            1259    16706    tests    VIEW     �   CREATE VIEW public.tests AS
 SELECT tests."id теста",
    tests."макс бал",
    tests."сложность теста"
   FROM tst.tests;
    DROP VIEW public.tests;
       public          postgres    false    215    215    215            �            1259    16626    view1    VIEW     �   CREATE VIEW public.view1 AS
 SELECT tests."id теста",
    tests."макс бал",
    tests."сложность теста"
   FROM tst.tests;
    DROP VIEW public.view1;
       public          postgres    false    215    215    215            �            1259    16575 !   Расчёт результата    TABLE     �   CREATE TABLE tst."Расчёт результата" (
    "id пользователя" bigint NOT NULL,
    "id задания" bigint NOT NULL,
    "Ответ" bigint,
    "id сессии" bigint
);
 4   DROP TABLE tst."Расчёт результата";
       tst         heap    postgres    false    6            v           0    0 )   TABLE "Расчёт результата"    ACL     .  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst."Расчёт результата" TO admins;
GRANT SELECT ON TABLE tst."Расчёт результата" TO users;
GRANT SELECT ON TABLE tst."Расчёт результата" TO for_read;
GRANT INSERT ON TABLE tst."Расчёт результата" TO for_insert;
GRANT UPDATE ON TABLE tst."Расчёт результата" TO for_update;
GRANT DELETE ON TABLE tst."Расчёт результата" TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst."Расчёт результата" TO managers;
          tst          postgres    false    218            �            1259    16578 /   Результаты пользователей    TABLE     -  CREATE TABLE tst."Результаты пользователей" (
    "id результата" bigint NOT NULL,
    "id пользователя" bigint,
    "id теста" bigint NOT NULL,
    "Результат" bigint,
    "id сессии" bigint,
    "Длительность" interval
);
 B   DROP TABLE tst."Результаты пользователей";
       tst         heap    postgres    false    6            w           0    0 7   TABLE "Результаты пользователей"    ACL     A  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst."Результаты пользователей" TO admins;
GRANT SELECT ON TABLE tst."Результаты пользователей" TO users;
GRANT SELECT ON TABLE tst."Результаты пользователей" TO user1;
GRANT SELECT ON TABLE tst."Результаты пользователей" TO for_read;
GRANT INSERT ON TABLE tst."Результаты пользователей" TO for_insert;
GRANT UPDATE ON TABLE tst."Результаты пользователей" TO for_update;
GRANT DELETE ON TABLE tst."Результаты пользователей" TO for_del;
GRANT SELECT ON TABLE tst."Результаты пользователей" TO small_user;
GRANT SELECT,INSERT,UPDATE ON TABLE tst."Результаты пользователей" TO managers;
          tst          postgres    false    219            x           0    0 V   COLUMN "Результаты пользователей"."id пользователя"    ACL     z   GRANT SELECT("id пользователя") ON TABLE tst."Результаты пользователей" TO small_user;
          tst          postgres    false    219    3447            y           0    0 M   COLUMN "Результаты пользователей"."Результат"    ACL     q   GRANT SELECT("Результат") ON TABLE tst."Результаты пользователей" TO small_user;
          tst          postgres    false    219    3447            �            1259    16714    who_not_work    VIEW     :  CREATE VIEW public.who_not_work AS
 SELECT "Расчёт результата"."id пользователя"
   FROM tst."Расчёт результата"
UNION
 SELECT "Результаты пользователей"."id пользователя"
   FROM tst."Результаты пользователей";
    DROP VIEW public.who_not_work;
       public          postgres    false    219    218            �            1259    16974 	   all_tests    VIEW     �   CREATE VIEW tst.all_tests AS
 SELECT tests."id теста",
    tests."макс бал",
    tests."сложность теста"
   FROM tst.tests;
    DROP VIEW tst.all_tests;
       tst          postgres    false    215    215    215    6            z           0    0    TABLE all_tests    ACL     x  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst.all_tests TO admins;
GRANT SELECT ON TABLE tst.all_tests TO users;
GRANT SELECT ON TABLE tst.all_tests TO for_read;
GRANT INSERT ON TABLE tst.all_tests TO for_insert;
GRANT UPDATE ON TABLE tst.all_tests TO for_update;
GRANT DELETE ON TABLE tst.all_tests TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst.all_tests TO managers;
          tst          postgres    false    226            �            1259    16978 
   count_task    VIEW     �   CREATE VIEW tst.count_task AS
 SELECT "Задания"."id темы",
    count("Задания"."id задания") AS count
   FROM tst."Задания"
  GROUP BY "Задания"."id темы";
    DROP VIEW tst.count_task;
       tst          postgres    false    216    216    6            {           0    0    TABLE count_task    ACL       GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst.count_task TO admins;
GRANT SELECT ON TABLE tst.count_task TO users;
GRANT SELECT ON TABLE tst.count_task TO for_read;
GRANT INSERT ON TABLE tst.count_task TO for_insert;
GRANT UPDATE ON TABLE tst.count_task TO for_update;
GRANT DELETE ON TABLE tst.count_task TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst.count_task TO managers;
          tst          postgres    false    227            �            1259    16986    python    VIEW     �   CREATE VIEW tst.python AS
 SELECT "Задания"."Задание",
    "Задания"."id темы"
   FROM tst."Задания"
  WHERE ("Задания"."id темы" = 1)
  WITH LOCAL CHECK OPTION;
    DROP VIEW tst.python;
       tst          postgres    false    216    216    6            |           0    0    TABLE python    ACL     c  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst.python TO admins;
GRANT SELECT ON TABLE tst.python TO users;
GRANT SELECT ON TABLE tst.python TO for_read;
GRANT INSERT ON TABLE tst.python TO for_insert;
GRANT UPDATE ON TABLE tst.python TO for_update;
GRANT DELETE ON TABLE tst.python TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst.python TO managers;
          tst          postgres    false    229            �            1259    17036    res    VIEW     �  CREATE VIEW tst.res AS
 SELECT res."id результата",
    res."id пользователя",
    res."id теста",
    res."Результат"
   FROM tst."Результаты пользователей" res
  WHERE (res."Результат" < ( SELECT tests."макс бал"
           FROM tst.tests tests
          WHERE (res."id теста" = tests."id теста")));
    DROP VIEW tst.res;
       tst          postgres    false    219    219    219    215    215    219    6            }           0    0 	   TABLE res    ACL     �   GRANT SELECT ON TABLE tst.res TO for_read;
GRANT INSERT ON TABLE tst.res TO for_insert;
GRANT UPDATE ON TABLE tst.res TO for_update;
GRANT DELETE ON TABLE tst.res TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst.res TO managers;
          tst          postgres    false    230            �            1259    16982    who_work    VIEW     3  CREATE VIEW tst.who_work AS
 SELECT "Расчёт результата"."id пользователя"
   FROM tst."Расчёт результата"
UNION
 SELECT "Результаты пользователей"."id пользователя"
   FROM tst."Результаты пользователей";
    DROP VIEW tst.who_work;
       tst          postgres    false    218    219    6            ~           0    0    TABLE who_work    ACL     q  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst.who_work TO admins;
GRANT SELECT ON TABLE tst.who_work TO users;
GRANT SELECT ON TABLE tst.who_work TO for_read;
GRANT INSERT ON TABLE tst.who_work TO for_insert;
GRANT UPDATE ON TABLE tst.who_work TO for_update;
GRANT DELETE ON TABLE tst.who_work TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst.who_work TO managers;
          tst          postgres    false    228            �            1259    16572    Пользователь    TABLE     �   CREATE TABLE tst."Пользователь" (
    "id пользователя" bigint NOT NULL,
    "почта" character varying(50),
    "пароль" character varying(50),
    "имя" character varying(50)
);
 +   DROP TABLE tst."Пользователь";
       tst         heap    postgres    false    6                       0    0     TABLE "Пользователь"    ACL     G  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst."Пользователь" TO admins;
GRANT SELECT ON TABLE tst."Пользователь" TO users;
GRANT SELECT ON TABLE tst."Пользователь" TO for_read;
GRANT INSERT ON TABLE tst."Пользователь" TO for_insert;
GRANT UPDATE ON TABLE tst."Пользователь" TO for_update;
GRANT DELETE ON TABLE tst."Пользователь" TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst."Пользователь" TO managers;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst."Пользователь" TO mega_user;
          tst          postgres    false    217            �            1259    17050    Сессии    TABLE     �   CREATE TABLE tst."Сессии" (
    "id сессии" bigint NOT NULL,
    "Время начала" date,
    "Время конца" date
);
    DROP TABLE tst."Сессии";
       tst         heap    postgres    false    6            �            1259    16581    тема    TABLE     i   CREATE TABLE tst."тема" (
    "id темы" bigint NOT NULL,
    "тема" character varying(20)
);
    DROP TABLE tst."тема";
       tst         heap    postgres    false    6            �           0    0    TABLE "тема"    ACL     �  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst."тема" TO admins;
GRANT SELECT ON TABLE tst."тема" TO users;
GRANT SELECT ON TABLE tst."тема" TO for_read;
GRANT INSERT ON TABLE tst."тема" TO for_insert;
GRANT UPDATE ON TABLE tst."тема" TO for_update;
GRANT DELETE ON TABLE tst."тема" TO for_del;
GRANT SELECT,INSERT,UPDATE ON TABLE tst."тема" TO managers;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tst."тема" TO mega_user;
          tst          postgres    false    220            c          0    16558    tests 
   TABLE DATA           �   COPY tst.tests ("id теста", "макс бал", "сложность теста", "Длительность теста") FROM stdin;
    tst          postgres    false    215   ��       d          0    16564    Задания 
   TABLE DATA           �   COPY tst."Задания" ("id задания", "Задание", "Вклад в баллах", "id теста", "Правильный ответ", "id темы") FROM stdin;
    tst          postgres    false    216   <�       e          0    16572    Пользователь 
   TABLE DATA           x   COPY tst."Пользователь" ("id пользователя", "почта", "пароль", "имя") FROM stdin;
    tst          postgres    false    217   -�       f          0    16575 !   Расчёт результата 
   TABLE DATA           �   COPY tst."Расчёт результата" ("id пользователя", "id задания", "Ответ", "id сессии") FROM stdin;
    tst          postgres    false    218   ��       g          0    16578 /   Результаты пользователей 
   TABLE DATA           �   COPY tst."Результаты пользователей" ("id результата", "id пользователя", "id теста", "Результат", "id сессии", "Длительность") FROM stdin;
    tst          postgres    false    219   Ռ       i          0    17050    Сессии 
   TABLE DATA           l   COPY tst."Сессии" ("id сессии", "Время начала", "Время конца") FROM stdin;
    tst          postgres    false    231   �       h          0    16581    тема 
   TABLE DATA           <   COPY tst."тема" ("id темы", "тема") FROM stdin;
    tst          postgres    false    220   /�       �           2606    16585    tests test_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY tst.tests
    ADD CONSTRAINT test_pkey PRIMARY KEY ("id теста");
 6   ALTER TABLE ONLY tst.tests DROP CONSTRAINT test_pkey;
       tst            postgres    false    215            �           2606    16587 "   Задания Задания_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY tst."Задания"
    ADD CONSTRAINT "Задания_pkey" PRIMARY KEY ("id задания");
 M   ALTER TABLE ONLY tst."Задания" DROP CONSTRAINT "Задания_pkey";
       tst            postgres    false    216            �           2606    16589 6   Пользователь Пользователь_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY tst."Пользователь"
    ADD CONSTRAINT "Пользователь_pkey" PRIMARY KEY ("id пользователя");
 a   ALTER TABLE ONLY tst."Пользователь" DROP CONSTRAINT "Пользователь_pkey";
       tst            postgres    false    217            �           2606    16591 H   Расчёт результата Расчёт результата_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY tst."Расчёт результата"
    ADD CONSTRAINT "Расчёт результата_pkey" PRIMARY KEY ("id пользователя", "id задания");
 s   ALTER TABLE ONLY tst."Расчёт результата" DROP CONSTRAINT "Расчёт результата_pkey";
       tst            postgres    false    218    218            �           2606    16593 d   Результаты пользователей Результаты пользователей_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY tst."Результаты пользователей"
    ADD CONSTRAINT "Результаты пользователей_pkey" PRIMARY KEY ("id результата");
 �   ALTER TABLE ONLY tst."Результаты пользователей" DROP CONSTRAINT "Результаты пользователей_pkey";
       tst            postgres    false    219            �           2606    17054    Сессии Сессии_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY tst."Сессии"
    ADD CONSTRAINT "Сессии_pkey" PRIMARY KEY ("id сессии");
 I   ALTER TABLE ONLY tst."Сессии" DROP CONSTRAINT "Сессии_pkey";
       tst            postgres    false    231            �           2606    16595    тема тема_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY tst."тема"
    ADD CONSTRAINT "тема_pkey" PRIMARY KEY ("id темы");
 A   ALTER TABLE ONLY tst."тема" DROP CONSTRAINT "тема_pkey";
       tst            postgres    false    220            �           2620    17020    Задания del_task_trig    TRIGGER     q   CREATE TRIGGER del_task_trig BEFORE DELETE ON tst."Задания" FOR EACH ROW EXECUTE FUNCTION tst.del_task();
 4   DROP TRIGGER del_task_trig ON tst."Задания";
       tst          postgres    false    216    250            �           2620    17012 .   Расчёт результата ins_res_trig    TRIGGER     �   CREATE TRIGGER ins_res_trig AFTER INSERT ON tst."Расчёт результата" FOR EACH ROW EXECUTE FUNCTION tst.ins_res();
 F   DROP TRIGGER ins_res_trig ON tst."Расчёт результата";
       tst          postgres    false    249    218            �           2606    16596 3   Расчёт результата id задания    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Расчёт результата"
    ADD CONSTRAINT "id задания" FOREIGN KEY ("id задания") REFERENCES tst."Задания"("id задания") NOT VALID;
 ^   ALTER TABLE ONLY tst."Расчёт результата" DROP CONSTRAINT "id задания";
       tst          postgres    false    3254    216    218            �           2606    16601 =   Расчёт результата id пользователя    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Расчёт результата"
    ADD CONSTRAINT "id пользователя" FOREIGN KEY ("id пользователя") REFERENCES tst."Пользователь"("id пользователя") NOT VALID;
 h   ALTER TABLE ONLY tst."Расчёт результата" DROP CONSTRAINT "id пользователя";
       tst          postgres    false    218    3256    217            �           2606    16606 K   Результаты пользователей id пользователя    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Результаты пользователей"
    ADD CONSTRAINT "id пользователя" FOREIGN KEY ("id пользователя") REFERENCES tst."Пользователь"("id пользователя") NOT VALID;
 v   ALTER TABLE ONLY tst."Результаты пользователей" DROP CONSTRAINT "id пользователя";
       tst          postgres    false    3256    217    219            �           2606    17055 1   Расчёт результата id сессии    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Расчёт результата"
    ADD CONSTRAINT "id сессии" FOREIGN KEY ("id сессии") REFERENCES tst."Сессии"("id сессии") NOT VALID;
 \   ALTER TABLE ONLY tst."Расчёт результата" DROP CONSTRAINT "id сессии";
       tst          postgres    false    231    3264    218            �           2606    17065 ?   Результаты пользователей id сессии    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Результаты пользователей"
    ADD CONSTRAINT "id сессии" FOREIGN KEY ("id сессии") REFERENCES tst."Сессии"("id сессии") NOT VALID;
 j   ALTER TABLE ONLY tst."Результаты пользователей" DROP CONSTRAINT "id сессии";
       tst          postgres    false    231    219    3264            �           2606    16611    Задания id темы    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Задания"
    ADD CONSTRAINT "id темы" FOREIGN KEY ("id темы") REFERENCES tst."тема"("id темы") NOT VALID;
 E   ALTER TABLE ONLY tst."Задания" DROP CONSTRAINT "id темы";
       tst          postgres    false    216    3262    220            �           2606    16616 =   Результаты пользователей id теста    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Результаты пользователей"
    ADD CONSTRAINT "id теста" FOREIGN KEY ("id теста") REFERENCES tst.tests("id теста") NOT VALID;
 h   ALTER TABLE ONLY tst."Результаты пользователей" DROP CONSTRAINT "id теста";
       tst          postgres    false    219    3252    215            �           2606    16621 0   Задания Задания_id теста_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tst."Задания"
    ADD CONSTRAINT "Задания_id теста_fkey" FOREIGN KEY ("id теста") REFERENCES tst.tests("id теста");
 [   ALTER TABLE ONLY tst."Задания" DROP CONSTRAINT "Задания_id теста_fkey";
       tst          postgres    false    216    3252    215            c   0   x�3�44�4�40�24�20�2ⴀp,@\cNCN#������� ��      d   �  x��X[OW~^~ŉ#��چ�K�C��U���6x	V�5���T2�@+�Di"UjsQڇ>�bo066���_�/�̜s�_
**��9���|gfΜ�5�;��S^�m^�U�^�Yv4�x���g0�r��cw�;��` �r_,YK���1������!����O���x��`���
��n�=�@R1^��;dD�a��2��t+8���Ii�H*lz�Z߸��+����Ik�7��wwx������}SY�\��OIC����{��5Ϋ~s��A�tP��<$�}���'�rMI)�/p��G � o(U
<��բ��DaH�'Ѵ�K�[�/D_j��G\:,xE�e��|[��17��R�MF��Ay�w��������*hn�� ﺠfbBx>�O[篍�����>7�ȸc}H�g�s��vw�P��2T�^��g�N4�v��!t�M+jĄF�b�
#��iݷ��>#�e}�Lk���9�/9k�R�YŸ�\f@�?��#TV�K�*�B��'��v-�K�o ���GF:�T�%��s�� ��kr�-�j v�v�i�XH5f�j^�w.�B���{�/�iF�XP��a��P�̑;l�X�p����en�ssA�u]�SF
�8��9�DK��xu�s�O0�%�	�TOr��|�&(�������U9���$-l��WF{G���)(�x�����)ŏ#��f�S�0�f����S0��i�]�z2�;����mD��J
��������T hP��m���*j��$��`���*�<4H��su`@"���	9SC�g�̿ƚ�b̫�`��qS� ��y�՟+���|[�5g.��/�n[BC��E�a���{0���$+,�
*�\�VY���I���eq�4P$��V�������d��H�M*w5�Y��vQG0�(4��>�b���?�=�B��v�a?����~|��^����%�Hߌ	]0��Y3,�Beg�NZ�L�I�"����D�f}�CY�K�2��-F6�G,��(�{�4��Ȳ_Z��c3J��b�IrPz��gP����w/ȩ�G9�M���@Bv"�~��E�ޤ�D?��l�{c=oFc	�,�`�^/V�%�.D)��(	:\��o��B��J��-V�I�ߎ�v'�Sa�lڰ��]�'l&�n-�zD��Y�6�燴���[��£�  /���k�+5x*�3H���{t}Z��y�}�56g"Ǩ����#���&�
����S_�7���t}~h�5���)����y+��f%o��8������9�6+?$^�d�M#���-Id�<�R��������W�Q�`=vT�L���B��x�N�P�kԤw�U
"Q��Q^�d��F���X ����Tj�ټQ��5��,ی�S}�� �`���GpQ� ���3��2!�D�DI ��:#o`<YY3J,��,�e�2#������9 Qܰ��<+��� B�����j��+���,�3 �FR��!�+LO�������M:zU��>��Z-Hh(���(��zDYC���pt�U�٢e]�0��j�h�lFө��Q��q���_��LO��p�,���eD�36�P
#��cc�'�	Pll�ws�'���ܔ6�K�3�)�De~���t6��7T�����>ԉ�R�"�\X1��"�z�Z�C�A�F�%�>Wކ��dx|�{�vxnԛ��m��:��W:/����	�D92��9��]�E��%D�W*�&⊆��z!��nvi����7�L!L�c���I}/�]��o*h6-u���g��v�~�)��#�B��#�l�p5&}i\T�D���NV�d|x�{�kķ�1�dJ�	?�}�01:�0�O�����6�+%�w����ZH��|�ݥ���u˭F�ZC��m���'�o��u�	���N�*���.u�d�6@dS���0,R�ǹ:��b���Gt�M�ם`T���l�G5Ս�O$�4�}��H^J�����,��      e   {   x�E�A
1E��a3�������H!픴���M��$�-�ɟ��ڪ�nXﶸ���>����O�>��i�\�4/��x�x��Q\u��A6qoO�x���"/֡� �Ȟ�%�J����7!      f      x������ � �      g      x�3�4�B+2�2r�8��b���� ��,      i      x�3�4202�50"Ӝ+F��� K��      h   $   x�3�,�,����2�L�2�L�/2�IL����� q�%     