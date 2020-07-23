--Rented movies by category (historical data)
select category.name,
count(category.name)
from public.rental 
inner join public.inventory on (rental.inventory_id =inventory.inventory_id )
inner join public.film_category on (inventory.film_id = film_category.film_id )
inner join public.category on (film_category.category_id =category.category_id )
group by category.name
order by count(category.name) desc

--Rented movies by category (last 30 days)
select category.name,
count(category.name)
from rental
inner join public.inventory on (rental.inventory_id =inventory.inventory_id )
inner join public.film_category on (inventory.film_id = film_category.film_id )
inner join public.category on (film_category.category_id =category.category_id )
where rental_date between (
	(select max(rental_date) from rental) - interval '30 days')
	and (select max(rental_date) from rental						  )
group by category.name
order by count(category.name) desc

--Top 10 customers overall
select 
concat(customer.first_name,' ', customer.last_name) as full_name,
count(concat(customer.first_name,' ', customer.last_name)) 
from customer
inner join rental on (customer.customer_id = rental.customer_id)
group by concat(customer.first_name,' ', customer.last_name)
order by count(concat(customer.first_name,' ', customer.last_name)) desc
limit 10

--Top 10 customers last month
select 
concat(customer.first_name,' ', customer.last_name) as full_name,
count(concat(customer.first_name,' ', customer.last_name)) 
from customer
inner join rental on (customer.customer_id = rental.customer_id)
where rental_date between (
	(select max(rental_date) from rental) - interval '30 days')
	and (select max(rental_date) from rental						  )
group by concat(customer.first_name,' ', customer.last_name)
order by count(concat(customer.first_name,' ', customer.last_name)) desc
limit 10

--Rent by store
select store.store_id, count(store.store_id)
from rental
inner join staff on rental.staff_id = staff.staff_id
inner join store on staff.store_id = store.store_id 
group by store.store_id 
order by count(store.store_id ) desc

--Top rented actors
select concat(actor.first_name,' ', actor.last_name),
count(concat(actor.first_name,' ', actor.last_name))
from rental
inner join inventory on rental.inventory_id = inventory.inventory_id 
inner join film_actor on inventory.film_id = film_actor.film_id 
inner join actor on film_actor.actor_id = actor.actor_id 
group by concat(actor.first_name,' ', actor.last_name)
order by count(concat(actor.first_name,' ', actor.last_name)) desc


--Actors per movie
select concat(actor.first_name,' ', actor.last_name),
count(concat(actor.first_name,' ', actor.last_name))
from film_actor
inner join actor on film_actor.actor_id = actor.actor_id 
group by concat(actor.first_name,' ', actor.last_name)
order by count(concat(actor.first_name,' ', actor.last_name)) desc