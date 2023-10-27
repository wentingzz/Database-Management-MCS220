
Find the item id of the item with the name ‘Laptop’. 

    π item_id (σ name='Laptop'(Item))


List the email of the sellers whose last name was ‘Taylor’

    π email (Seller ⨝ (σlast_name='Taylor' Users))
Select the first and last names of users who bought an item with the name ‘Hoodie’. 

    π first_name,last_name((π buyer_user_id (σ name='Hoodie' (Item))) ⨝ buyer_user_id=Users.user_id (Users))

List the user_id of the buyer who rated a seller who sells an item with item_id 'DB81G'. 

    π buyer_id ((π seller_user_id (σ item_id='DB81G' (Item))) ⨝ Item.seller_user_id=Ratings.seller_id (Ratings))

List the user emails and first names of users who bought at least one item of the category ‘Electronics’ or ‘Sports & Outdoors’ on the platform and who live in the city “Port Angela”. 

    π email,first_name((π buyer_user_id(σ category='Electronics'∨category='Sports & Outdoors' (Item)))⨝Item.buyer_user_id=Users.user_id (σcity='Port Angela' Users))

List the emails, first names, and last names of users who are both a buyer and a seller on the platform and who are a resident of the state ‘Virginia’ 

    π email,first_name,last_name((π user_id (Buyer)∩ π user_id(Seller))⨝Buyer.user_id=Users.user_id (σ state='Virginia' Users))

List the ad ids of advertisements that have the picture with pic_num of ‘3’ and are associated with the item with item_id of ’Q65ZT’. 

    π ad_id σ pic_num='3'∧ item_id='Q65ZT' (Ad)

List the mobile phone numbers (i.e., of kind ‘MOBILE’) of all the sellers who listed items on the platform on the date “2022-07-17”.

    πnumber ((πseller_user_id σlist_date='2022-07-17' (Item))⨝Item.seller_user_id=Phone.user_id σkind='MOBILE' Phone)

