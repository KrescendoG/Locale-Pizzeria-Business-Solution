SELECT
	o.order_id,
	i.price,
	o.quantity_ordered,
	i.category,
	i.item_name,
	o.creation_time,
	a.address,
	a.city,
	a.postal_code,
	o.is_delivery 
FROM
	orders o
	LEFT JOIN item i ON o.item_id = i.item_id
	LEFT JOIN address a ON o.address_id = a.address_id