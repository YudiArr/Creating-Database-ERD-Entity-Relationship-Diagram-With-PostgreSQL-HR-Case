-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.countries
(
    country_id character(2) NOT NULL,
    country_name character varying(40),
    region_id integer NOT NULL,
    PRIMARY KEY (country_id)
);

CREATE TABLE IF NOT EXISTS public.departments
(
    department_id integer NOT NULL,
    department_name character varying(30) NOT NULL,
    manager_id integer,
    location_id integer,
    PRIMARY KEY (department_id)
);

CREATE TABLE IF NOT EXISTS public.employees
(
    employee_id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(25) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(20),
    hire_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    salary numeric(8, 2) NOT NULL,
    commission_pct numeric(2, 2),
    manager_id integer,
    department_id integer,
    PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS public.job_history
(
    employee_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    department_id integer NOT NULL,
    PRIMARY KEY (employee_id, start_date)
);

CREATE TABLE IF NOT EXISTS public.jobs
(
    job_id character varying(10) NOT NULL,
    job_title character varying(35) NOT NULL,
    min_salary numeric(8, 2),
    max_salary numeric(8, 2),
    PRIMARY KEY (job_id)
);

CREATE TABLE IF NOT EXISTS public.locations
(
    location_id integer NOT NULL,
    street_address character varying(40),
    postal_code character varying(12),
    city character varying(30) NOT NULL,
    state_province character varying(25),
    country_id character(2) NOT NULL,
    PRIMARY KEY (location_id)
);

CREATE TABLE IF NOT EXISTS public.regions
(
    region_id integer NOT NULL,
    region_name character varying(25),
    PRIMARY KEY (region_id)
);

ALTER TABLE IF EXISTS public.countries
    ADD FOREIGN KEY (region_id)
    REFERENCES public.regions (region_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.departments
    ADD FOREIGN KEY (manager_id)
    REFERENCES public.employees (employee_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.employees
    ADD FOREIGN KEY (manager_id)
    REFERENCES public.employees (employee_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.job_history
    ADD FOREIGN KEY (job_id)
    REFERENCES public.jobs (job_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.job_history
    ADD FOREIGN KEY (employee_id)
    REFERENCES public.employees (employee_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.job_history
    ADD FOREIGN KEY (department_id)
    REFERENCES public.departments (department_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.locations
    ADD FOREIGN KEY (country_id)
    REFERENCES public.countries (country_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;