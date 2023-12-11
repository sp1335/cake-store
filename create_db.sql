CREATE TABLE addresses (
    city               VARCHAR(50) NOT NULL,
    address_line       VARCHAR(100) NOT NULL,
    postal_code        VARCHAR(4000) NOT NULL,
    phone_INTEGER       VARCHAR(25),
    address_name       VARCHAR(25) NOT NULL,
    customer_info_ciid INTEGER NOT NULL
);

ALTER TABLE addresses ADD CONSTRAINT addresses_pk PRIMARY KEY ( customer_info_ciid );

CREATE TABLE auth_tokens (
    access_token  VARCHAR(600) NOT NULL,
    refresh_token VARCHAR(600) NOT NULL,
    user_uid      INTEGER NOT NULL
);

CREATE TABLE comments (
    text        VARCHAR(500) NOT NULL,
    timestamp   TIMESTAMP NOT NULL,
    user_uid    INTEGER NOT NULL,
    product_pid INTEGER
);

CREATE TABLE customer_info (
    ciid         INTEGER NOT NULL,
    email        VARCHAR(50),
    phone_INTEGER VARCHAR(12) NOT NULL,
    name         VARCHAR(25) NOT NULL,
    surname      VARCHAR(25) NOT NULL,
    user_uid     INTEGER NOT NULL
);

ALTER TABLE customer_info ADD CONSTRAINT customer_info_pk PRIMARY KEY ( ciid );

CREATE TABLE news_feed (
    nid          INTEGER NOT NULL,
    title        VARCHAR(100) NOT NULL,
    text         VARCHAR(500) NOT NULL,
    img_url      VARCHAR(4000),
    publish_date TIMESTAMP NOT NULL,
    user_uid     INTEGER NOT NULL
);

ALTER TABLE news_feed ADD CONSTRAINT news_feed_pk PRIMARY KEY ( nid );

CREATE TABLE "order" (
    oid                         INTEGER NOT NULL,
    status                      VARCHAR(4000) NOT NULL,
    last_modification_timestamp TIMESTAMP NOT NULL,
    delivery_type               VARCHAR(4000),
    total                       INTEGER NOT NULL,
    customer_info_ciid          INTEGER NOT NULL,
    user_uid                    INTEGER NOT NULL
);

ALTER TABLE "order" ADD CONSTRAINT order_pk PRIMARY KEY ( oid );

CREATE TABLE order_item (
    quantity    INTEGER NOT NULL,
    product_pid INTEGER NOT NULL,
    order_oid   INTEGER NOT NULL
);

CREATE TABLE payment_details (
    card_type          VARCHAR(4000) NOT NULL,
    card_INTEGER        INTEGER NOT NULL,
    secure_code        INTEGER NOT NULL,
    holder_name        VARCHAR(50) NOT NULL,
    customer_info_ciid INTEGER NOT NULL
);

ALTER TABLE payment_details ADD CONSTRAINT payment_details_pk PRIMARY KEY ( customer_info_ciid );

CREATE TABLE product (
    pid                      INTEGER NOT NULL,
    type                     VARCHAR(50) NOT NULL,
    name                     VARCHAR(50) NOT NULL,
    price                    INTEGER NOT NULL,
    description              VARCHAR(4000) NOT NULL,
    order_item_order_item_id INTEGER NOT NULL
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( pid );

CREATE TABLE "user" (
    "uid"                      INTEGER NOT NULL,
    username                   VARCHAR(50) NOT NULL,
    user_type_utid             INTEGER NOT NULL,
    customer_info_ciid         INTEGER NOT NULL,
    password_hash              VARCHAR(4000) NOT NULL,
    auth_tokens_auth_tokens_id INTEGER NOT NULL
);

ALTER TABLE "user" ADD CONSTRAINT user_pk PRIMARY KEY ( "uid" );

CREATE TABLE user_type (
    utid      INTEGER NOT NULL,
    user_type VARCHAR(15) NOT NULL
);

ALTER TABLE user_type ADD CONSTRAINT user_type_pk PRIMARY KEY ( utid );

ALTER TABLE addresses
    ADD CONSTRAINT addresses_customer_info_fk FOREIGN KEY ( customer_info_ciid )
        REFERENCES customer_info ( ciid );

ALTER TABLE auth_tokens
    ADD CONSTRAINT auth_tokens_user_fk FOREIGN KEY ( user_uid )
        REFERENCES "user" ( "uid" );

ALTER TABLE comments
    ADD CONSTRAINT comments_product_fk FOREIGN KEY ( product_pid )
        REFERENCES product ( pid );

ALTER TABLE comments
    ADD CONSTRAINT comments_user_fk FOREIGN KEY ( user_uid )
        REFERENCES "user" ( "uid" );

ALTER TABLE customer_info
    ADD CONSTRAINT customer_info_user_fk FOREIGN KEY ( user_uid )
        REFERENCES "user" ( "uid" );

ALTER TABLE news_feed
    ADD CONSTRAINT news_feed_user_fk FOREIGN KEY ( user_uid )
        REFERENCES "user" ( "uid" );

ALTER TABLE "order"
    ADD CONSTRAINT order_customer_info_fk FOREIGN KEY ( customer_info_ciid )
        REFERENCES customer_info ( ciid );

ALTER TABLE order_item
    ADD CONSTRAINT order_item_order_fk FOREIGN KEY ( order_oid )
        REFERENCES "order" ( oid );

ALTER TABLE order_item
    ADD CONSTRAINT order_item_product_fk FOREIGN KEY ( product_pid )
        REFERENCES product ( pid );

ALTER TABLE "order"
    ADD CONSTRAINT order_user_fk FOREIGN KEY ( user_uid )
        REFERENCES "user" ( "uid" );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE payment_details
    ADD CONSTRAINT payment_details_customer_info_fk FOREIGN KEY ( customer_info_ciid )
        REFERENCES customer_info ( ciid );

ALTER TABLE "user"
    ADD CONSTRAINT user_user_type_fk FOREIGN KEY ( user_type_utid )
        REFERENCES user_type ( utid );