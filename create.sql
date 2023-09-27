--SQL DDLs for Entities and their supporting tables

CREATE SCHEMA IF NOT EXISTS CS220;
CREATE TABLE CS220.Users (
  user_id integer,
  email text NOT NULL,

  address_street text,
  address_state text,
  address_city text,
  address_zip integer,
  categories text,
  joined_date date NOT NULL,
  first_name text,
  last_name text NOT NULL,

  PRIMARY KEY (user_id),
  UNIQUE(email)
);

CREATE TYPE phone_type as ENUM('work','home','mobile');

CREATE TABLE CS220.Phones(
  user_id integer NOT NULL,
  phone_number text,
  kind phone_type,
  PRIMARY KEY (user_id, kind),
  FOREIGN KEY (user_id) REFERENCES CS220.Users ON DELETE CASCADE
);

CREATE TABLE CS220.Buyer(
  user_id integer,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES CS220.Users(user_id) ON DELETE CASCADE
);

CREATE TABLE CS220.Seller(
  user_id integer,
  website text,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES CS220.Users(user_id) ON DELETE CASCADE
);

CREATE TABLE CS220.Item(
  item_id SERIAL,
  name text NOT NULL,
  price decimal(10,2) NOT NULL,
  category text NOT NULL,
  description text,

  sellerID integer NOT NULL,
  list_date date NOT NULL,
  PRIMARY KEY (item_id),
  FOREIGN KEY (sellerID) REFERENCES CS220.Seller(user_id)
);

CREATE TABLE CS220.Good(
  item_id integer,

  PRIMARY KEY (item_id),
  FOREIGN KEY (item_id) REFERENCES CS220.Item(item_id) ON DELETE CASCADE
);

CREATE TYPE frequency_type as ENUM('once','daily', 'weekly', 'monthly', 'quarterly', 'yearly');
CREATE TABLE CS220.Service(
  item_id integer,
  frequency frequency_type NOT NULL,

  PRIMARY KEY (item_id),
  FOREIGN KEY (item_id) REFERENCES CS220.Item(item_id) ON DELETE CASCADE
);

CREATE TYPE pic_format AS ENUM('png','jpeg','mp4');
CREATE TABLE CS220.Picture(
  pic_num integer NOT NULL,
  url text NOT NULL,
  format pic_format NOT NULL,
  item_id integer NOT NULL,
  PRIMARY KEY (item_id, pic_num),
  FOREIGN KEY (item_id) REFERENCES CS220.Item(item_id) ON DELETE CASCADE
);

CREATE TYPE plan_level AS ENUM('bronze’, ‘gold’, ‘silver’, ‘platinum');
CREATE TABLE CS220.Ad(
  ad_id integer,
  plan plan_level NOT NULL,
  content text,

  itemID integer NOT NULL,
  picNum integer NOT NULL,
  sellerID integer NOT NULL,
  placed_date date NOT NULL,
  PRIMARY KEY (ad_id),
  FOREIGN KEY (itemID, picNum) REFERENCES CS220.Picture(item_id, pic_num),
  FOREIGN KEY (sellerID) REFERENCES CS220.Seller(user_id)
);




--SQL DDLs for Relationships
CREATE TABLE CS220.Ratings(
  rater integer NOT NULL,
  ratee integer NOT NULL,
  rating_date date NOT NULL,
  pricing integer,
  delivery integer,
  quality integer,
  PRIMARY KEY (rater, ratee),
  FOREIGN KEY (rater) REFERENCES CS220.Buyer(user_id),
  FOREIGN KEY (ratee) REFERENCES CS220.Seller(user_id)
);

CREATE TABLE CS220.Buys(
  buy_id SERIAL,
  buyerID integer NOT NULL,
  itemID integer NOT NULL,
  purchase_date date NOT NULL,
  PRIMARY KEY (buy_id),
  FOREIGN KEY (buyerID) REFERENCES CS220.Buyer(user_id),
  FOREIGN KEY (itemID) REFERENCES CS220.Item(item_id)
);




