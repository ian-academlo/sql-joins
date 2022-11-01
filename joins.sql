CREATE TABLE "clients" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "phone" varchar,
  "email" varchar
);

CREATE TABLE "products" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "flavor" varchar,
  "price" float,
  "stock" int
);

CREATE TABLE "orders" (
  "id" SERIAL PRIMARY KEY,
  "client_id" int NOT NULL,
  "order_date" timestamp DEFAULT 'now()'
);

CREATE TABLE "orders_products" (
  "id" SERIAL PRIMARY KEY,
  "order_id" int NOT NULL,
  "product_id" int NOT NULL,
  "quantity" int
);

ALTER TABLE "orders" ADD FOREIGN KEY ("client_id") REFERENCES "clients" ("id");

ALTER TABLE "orders_products" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "orders_products" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");


insert into clients (name, phone, email) values
('Ian', '0000000000', 'ian@gmail.com'),
('Flor', '1111111111', 'flor@gmail.com'),
('Daniela', '2222222222', 'daniela@gmail.com'),
('David', '3333333333', 'david@gmail.com');

select * from clients;

insert into products (name, flavor, price, stock) values 
('cocacola', 'cola', 2.0, 100),
('pepsi', 'cola', 1.8, 200),
('fanta', 'naranja', 1.6, 120),
('7up', 'lima limon', 1.7, 90);

select * from products;


insert into orders (client_id) values (1);

select * from orders;

insert into orders_products (order_id, product_id, quantity) values 
(1, 1, 2);

select *  from orders_products;


insert into orders (client_id) values (3);

insert into orders_products (order_id, product_id, quantity) values 
(2, 1, 4), 
(2, 3, 2),
(2, 4, 3);

que hagas una consulta donde me aparezca el nombre del cliente y nombre y cantidad del producto

select name from clients where id = 1; 

select * from clients
join orders
on clients.id = orders.client_id; 

select clients.name, orders.id  from clients
inner join orders
on clients.id = orders.client_id;

select c.name, o.id  from clients c
inner join orders o
on c.id = o.client_id
where c.id = 3;

mostrar el total de la orden con id 1

select p.price * op.quantity as total from products p
join orders_products op
on p.id = op.product_id
where op.order_id = 1;

select * from clients c
left join orders o
on c.id = o.client_id;

los clientes que no han comprado
select * from clients c
left join orders o
on c.id = o.client_id
where o.id is null;

nombre del cliente con el producto que compro 

select c.name, p."name"  from clients c
join orders o
on c.id = o.client_id
join orders_products op
on o.id = op.order_id
join products p
on op.product_id = p.id;
