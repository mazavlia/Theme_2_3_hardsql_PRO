CREATE TABLE IF NOT EXISTS public.authors
(
    author_id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 ),
    author_name character varying(150) COLLATE pg_catalog."default",
    CONSTRAINT author_pkey PRIMARY KEY (author_id)
);


CREATE TABLE IF NOT EXISTS public.publish_houses
(
    publ_house_id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 ),
    house_name character varying(120) COLLATE pg_catalog."default" NOT NULL,
    city character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT publish_house_pkey PRIMARY KEY (publ_house_id)
);


CREATE TABLE IF NOT EXISTS public.readers
(
    readers_ticket_id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 ),
    full_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    adress character varying(200) COLLATE pg_catalog."default",
    telephone character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT "Readers_pkey" PRIMARY KEY (readers_ticket_id)
);


CREATE TABLE IF NOT EXISTS public.books
(
    book_id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 ),
    title character varying(100) COLLATE pg_catalog."default" NOT NULL,
    author_id BIGINT NOT NULL,
    co_author1_id BIGINT,
    co_author2_id BIGINT,
    co_author3_id BIGINT,
    public_year integer NOT NULL,
    amount_pages integer NOT NULL,
    price DECIMAL(5, 2) NOT NULL,
    amount integer NOT NULL,
    publ_house_id BIGINT,
    CONSTRAINT books_pkey PRIMARY KEY (book_id),
    CONSTRAINT author_id FOREIGN KEY (author_id)
        REFERENCES public.authors (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT co_author_1_fk FOREIGN KEY (co_author1_id)
        REFERENCES public.authors (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT co_author_2_fk FOREIGN KEY (co_author2_id)
        REFERENCES public.authors (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT co_author_3_fk FOREIGN KEY (co_author3_id)
        REFERENCES public.authors (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT publ_house_fk FOREIGN KEY (publ_house_id)
        REFERENCES public.publish_houses (publ_house_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);


CREATE TABLE IF NOT EXISTS public.book_rentals
(
    rent_id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 ),
    readers_ticket_id BIGINT NOT NULL,
    book_id BIGINT NOT NULL,
    start_rental date NOT NULL,
    stop_rental date,
    CONSTRAINT book_rental_pkey PRIMARY KEY (rent_id),
    CONSTRAINT book_rental_book_id_fkey FOREIGN KEY (book_id)
        REFERENCES public.books (book_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT book_rental_readers_ticket_id_fkey FOREIGN KEY (readers_ticket_id)
        REFERENCES public.readers (readers_ticket_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);