SELECT
	s1.item_name AS item_name,
	s1.ing_name AS ing_name,
	s1.ing_id AS ing_id,
	s1.ing_weight AS ing_weight,
	s1.ing_price AS ing_price,
	s1.order_quantity AS order_quantity,
	s1.recipe_quantity AS recipe_quantity,(
		s1.order_quantity * s1.recipe_quantity 
		) AS ordered_weight,(
		s1.ing_price / s1.ing_weight 
		) AS unit_cost,((
			s1.order_quantity * s1.recipe_quantity 
		) * ( s1.ing_price / s1.ing_weight )) AS ingredient_cost 
FROM
	(
	SELECT
		o.item_id AS item_id,
		i.prep_id AS sku,
		i.item_name AS item_name,
		p.ingredient_id AS ing_id,
		ing.name AS ing_name,
		ing.weight AS ing_weight,
		ing.price AS ing_price,
		sum( o.quantity_ordered ) AS order_quantity,
		p.quantity AS recipe_quantity 
	FROM
		(((
					orders o
					LEFT JOIN item i ON ((
							o.item_id = i.item_id 
						)))
				LEFT JOIN Preparations p ON ((
						i.prep_id = p.prep_id 
					)))
			LEFT JOIN Ingredients ing ON ((
					ing.ingredient_id = p.ingredient_id 
				))) 
	GROUP BY
		o.item_id,
		i.prep_id,
		i.item_name,
		p.ingredient_id,
		p.quantity,
		ing.name,
		ing.weight,
	ing.price 
	) s1