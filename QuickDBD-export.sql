-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [Orders] (
    [serial_key] int  NOT NULL ,
    [order_id] varchar(20)  NOT NULL ,
    [creation_time] datetime  NOT NULL ,
    [item_id] varchar(20)  NOT NULL ,
    [quantity_ordered] int  NOT NULL ,
    [customer_id] int  NOT NULL ,
    [is_delivery] boolean  NOT NULL ,
    [address_id] int  NOT NULL ,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED (
        [serial_key] ASC
    )
)

CREATE TABLE [Customers] (
    [customer_id] int  NOT NULL ,
    [first_name] varchar(50)  NOT NULL ,
    [last_name] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED (
        [customer_id] ASC
    )
)

CREATE TABLE [Address] (
    [address_id] int  NOT NULL ,
    [address] varchar(100)  NOT NULL ,
    [city] varchar(20)  NOT NULL ,
    [postal_code] varchar(10)  NOT NULL ,
    CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED (
        [address_id] ASC
    )
)

CREATE TABLE [Item] (
    [item_id] varchar(20)  NOT NULL ,
    [prep_id] varchar(50)  NOT NULL ,
    [item_name] varchar(100)  NOT NULL ,
    [category] varchar(50)  NOT NULL ,
    [item_size] varchar(20)  NOT NULL ,
    [price] float  NOT NULL ,
    CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED (
        [item_id] ASC
    )
)

CREATE TABLE [Preparations] (
    [serial_key] int  NOT NULL ,
    [prep_id] varchar(50)  NOT NULL ,
    [ingredient_id] varchar(20)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_Preparations] PRIMARY KEY CLUSTERED (
        [serial_key] ASC
    )
)

CREATE TABLE [Ingredients] (
    [ingredient_id] varchar(20)  NOT NULL ,
    [name] varchar(100)  NOT NULL ,
    [weight] float  NOT NULL ,
    [measure] varchar(50)  NOT NULL ,
    [price] float  NOT NULL ,
    CONSTRAINT [PK_Ingredients] PRIMARY KEY CLUSTERED (
        [ingredient_id] ASC
    )
)

CREATE TABLE [Inventory] (
    [inventory_id] int  NOT NULL ,
    [ingredient_id] varchar(20)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED (
        [inventory_id] ASC
    )
)

CREATE TABLE [Employees] (
    [emp_id] varchar(20)  NOT NULL ,
    [first_name] varchar(100)  NOT NULL ,
    [last_name] varchar(100)  NOT NULL ,
    [designation] varchar(100)  NOT NULL ,
    [hourly_wage] float  NOT NULL ,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED (
        [emp_id] ASC
    )
)

CREATE TABLE [Shifts] (
    [shift_id] varchar(20)  NOT NULL ,
    [day_of_the_week] varchar(20)  NOT NULL ,
    [start_time] time  NOT NULL ,
    [end_time] time  NOT NULL ,
    CONSTRAINT [PK_Shifts] PRIMARY KEY CLUSTERED (
        [shift_id] ASC
    )
)

CREATE TABLE [Schedule] (
    [serial_key] int  NOT NULL ,
    [sch_id] varchar(20)  NOT NULL ,
    [date] datetime  NOT NULL ,
    [emp_id] varchar(20)  NOT NULL ,
    [shift_id] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED (
        [serial_key] ASC
    )
)

ALTER TABLE [Orders] WITH CHECK ADD CONSTRAINT [FK_Orders_creation_time] FOREIGN KEY([creation_time])
REFERENCES [Schedule] ([date])

ALTER TABLE [Orders] CHECK CONSTRAINT [FK_Orders_creation_time]

ALTER TABLE [Customers] WITH CHECK ADD CONSTRAINT [FK_Customers_customer_id] FOREIGN KEY([customer_id])
REFERENCES [Orders] ([customer_id])

ALTER TABLE [Customers] CHECK CONSTRAINT [FK_Customers_customer_id]

ALTER TABLE [Address] WITH CHECK ADD CONSTRAINT [FK_Address_address_id] FOREIGN KEY([address_id])
REFERENCES [Orders] ([address_id])

ALTER TABLE [Address] CHECK CONSTRAINT [FK_Address_address_id]

ALTER TABLE [Item] WITH CHECK ADD CONSTRAINT [FK_Item_item_id] FOREIGN KEY([item_id])
REFERENCES [Orders] ([item_id])

ALTER TABLE [Item] CHECK CONSTRAINT [FK_Item_item_id]

ALTER TABLE [Item] WITH CHECK ADD CONSTRAINT [FK_Item_prep_id] FOREIGN KEY([prep_id])
REFERENCES [Preparations] ([prep_id])

ALTER TABLE [Item] CHECK CONSTRAINT [FK_Item_prep_id]

ALTER TABLE [Preparations] WITH CHECK ADD CONSTRAINT [FK_Preparations_ingredient_id] FOREIGN KEY([ingredient_id])
REFERENCES [Inventory] ([ingredient_id])

ALTER TABLE [Preparations] CHECK CONSTRAINT [FK_Preparations_ingredient_id]

ALTER TABLE [Ingredients] WITH CHECK ADD CONSTRAINT [FK_Ingredients_ingredient_id] FOREIGN KEY([ingredient_id])
REFERENCES [Preparations] ([ingredient_id])

ALTER TABLE [Ingredients] CHECK CONSTRAINT [FK_Ingredients_ingredient_id]

ALTER TABLE [Employees] WITH CHECK ADD CONSTRAINT [FK_Employees_emp_id] FOREIGN KEY([emp_id])
REFERENCES [Schedule] ([emp_id])

ALTER TABLE [Employees] CHECK CONSTRAINT [FK_Employees_emp_id]

ALTER TABLE [Shifts] WITH CHECK ADD CONSTRAINT [FK_Shifts_shift_id] FOREIGN KEY([shift_id])
REFERENCES [Schedule] ([shift_id])

ALTER TABLE [Shifts] CHECK CONSTRAINT [FK_Shifts_shift_id]

COMMIT TRANSACTION QUICKDBD