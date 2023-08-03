-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/5vP2LV
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "cardholder" (
    "cardholder_id" int   NOT NULL,
    "cardholder_nm" varchar(255)   NOT NULL,
    CONSTRAINT "pk_cardholder" PRIMARY KEY (
        "cardholder_id"
     )
);

CREATE TABLE "credit_card" (
    "credit_card_nbr" varchar(20)   NOT NULL,
    "cardholder_id" int   NOT NULL,
    CONSTRAINT "pk_credit_card" PRIMARY KEY (
        "credit_card_nbr"
     )
);

CREATE TABLE "merchant" (
    "merchant_id" int   NOT NULL,
    "merchant_nm" varchar(255)   NOT NULL,
    "merchant_cat_id" int   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "merchant_id"
     )
);

CREATE TABLE "merchant_cat" (
    "merchant_cat_id" int   NOT NULL,
    "merchant_cat_nm" varchar(255)   NOT NULL,
    CONSTRAINT "pk_merchant_cat" PRIMARY KEY (
        "merchant_cat_id"
     ),
    CONSTRAINT "uc_merchant_cat_merchant_cat_nm" UNIQUE (
        "merchant_cat_nm"
    )
);

CREATE TABLE "transaction" (
    "transaction_id" int   NOT NULL,
    "transaction_dt" timestamp   NOT NULL,
    "transaction_amt" float8   NOT NULL,
    "credit_card_nbr" varchar(20)   NOT NULL,
    "merchant_id" int   NOT NULL,
    CONSTRAINT "pk_transaction" PRIMARY KEY (
        "transaction_id"
     )
);

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_cardholder_id" FOREIGN KEY("cardholder_id")
REFERENCES "cardholder" ("cardholder_id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_merchant_cat_id" FOREIGN KEY("merchant_cat_id")
REFERENCES "merchant_cat" ("merchant_cat_id");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_credit_card_nbr" FOREIGN KEY("credit_card_nbr")
REFERENCES "credit_card" ("credit_card_nbr");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_merchant_id" FOREIGN KEY("merchant_id")
REFERENCES "merchant" ("merchant_id");

