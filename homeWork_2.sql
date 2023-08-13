CREATE TABLE IF NOT EXISTS persons(
  id SERIAL PRIMARY KEY,
  name VARCHAR(64) NOT NULL CHECK(name <> ''),
  address VARCHAR(200) NOT NULL CHECK(address <> ''),
  phone_number VARCHAR(10) NOT NULL UNIQUE CHECK(phone_number ~ '[0-9]{10,10}')
);
CREATE TABLE IF NOT EXISTS products(
  id SERIAL PRIMARY KEY,
  name VARCHAR(64) NOT NULL CHECK(name <> ''),
  price NUMERIC(15, 3) NOT NULL CHECK(price > 0)
);
CREATE TABLE IF NOT EXISTS treatys(
  id SERIAL PRIMARY KEY,
  number VARCHAR(64) NOT NULL CHECK(number <> ''),
  date DATE NOT NULL
);
CREATE TABLE IF NOT EXISTS supplys(
  id SERIAL PRIMARY KEY,
  recipient_id INTEGER NOT NULL REFERENCES persons,
  date DATE NOT NULL
);
CREATE TABLE IF NOT EXISTS orders(
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES persons,
  treaty_id INTEGER NOT NULL REFERENCES treatys,
  product_id INTEGER NOT NULL REFERENCES products,
  quantity_product NUMERIC(9) NOT NULL CHECK(quantity_product > 0)
);
CREATE TABLE IF NOT EXISTS orders_to_supplys(
  supply_id INTEGER REFERENCES supplys,
  order_id INTEGER REFERENCES orders,
  quantity_product_supply NUMERIC(9) NOT NULL CHECK(quantity_product_supply > 0),
  PRIMARY KEY (supply_id, order_id)
);