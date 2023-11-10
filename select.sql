--Find the item ids of the item with the name ‘Laptop’ and limit your results to the top 5 costliest items. [10pts]
SELECT  item_id
FROM cs222p_interchange.item
WHERE name = 'Laptop'
ORDER BY price DESC LIMIT 5

--List the email of the sellers whose last name was ‘Taylor’ [10pts]
SELECT u.email
FROM cs222p_interchange.User u, cs222p_interchange.Seller s
WHERE u.user_id = s.user_id AND u.last_name = 'Taylor'

--Select the first and last names of users who bought an item with the name ‘Hoodie’. Sort the results in ascending order based on the first name  [10pts].
SELECT u.first_name, u.last_name
FROM cs222p_interchange.Item i, cs222p_interchange.User u
WHERE u.user_id = i.buyer_user_id AND i.name = 'Hoodie'
ORDER BY u.first_name ASC

--List the user_id of the buyer who rated a seller who sells an item with item_id  ‘G9WMY’. Order the results in descending order of the seller’s quality rating.[10pts].
SELECT r.buyer_id
FROM cs222p_interchange.Item i, cs222p_interchange.Ratings r
WHERE r.seller_id = i.seller_user_id AND i.item_id = 'G9WMY'
ORDER BY r.quality DESC

--List the user emails and first names of users who bought at least one item of the category "Clothing, Shoes & Jewelry" or "Toys & Games"  on the platform and who live in the city “Josephstad”.  [15pts].
SELECT u.email, u.first_name
FROM cs222p_interchange.Item i, cs222p_interchange.User u
WHERE u.user_id = i.buyer_user_id AND (i.category = 'Clothing, Shoes & Jewelry' OR i.category = 'Toys & Games') AND u.city = 'Josephstad'

--List the emails, first names, and last names of users who are both a buyer and a seller on the platform and who are a resident of the state ‘West Virgina’ and order the results using zipcode in ascending order [15pts].
SELECT u.email, u.first_name, u.last_name
FROM cs222p_interchange.Seller s, cs222p_interchange.Buyer b, cs222p_interchange.User u
WHERE s.user_id = b.user_id AND s.user_id = u.user_id AND u.state = 'West Virginia'
ORDER BY u.zip ASC

--List the ad ids of advertisements that have a picture with a pic_num of ‘2’ and are associated with an item of the category ‘Electronics’ with a price under 1000. Order the results by ad_id in ascending order and limit the results to 5 records [15pts].
SELECT ad.ad_id
FROM cs222p_interchange.Ad ad, cs222p_interchange.Item i, cs222p_interchange.Picture pic
WHERE i.item_id = ad.item_id AND i.category = 'Electronics' and i.price < 1000 AND pic.item_id = ad.item_id AND pic.pic_num = '2'
ORDER BY ad.ad_id ASC
LIMIT 5

--List the mobile phone numbers (i.e., of kind ‘MOBILE’) of all the sellers who listed items on the platform on the date “2022-07-17”. Limit your output to 10 records [15pts].
SELECT ph.number
FROM cs222p_interchange.Phone ph, cs222p_interchange.Item i
WHERE i.seller_user_id = ph.user_id AND ph.kind = 'mobile' AND i.list_date = '2022-07-17'
LIMIT 10


-- HW6
-- For all buyers who bought at least 3 items after the date 2022-07-24, list each buyer's user_id, first_name, and last_name.
SELECT U.user_id, U.first_name, U.last_name
FROM cs222p_interchange.User U
INNER JOIN (
	SELECT B.user_id
	FROM cs222p_interchange.buyer B
	WHERE (
		SELECT COUNT(*)
		FROM cs222p_interchange.item I
		WHERE B.user_id = I.buyer_user_id AND I.purchase_date > '2022-07-24'
	) >= 3
) tmp ON tmp.user_id = U.user_id

--Find the highest price for each item sold by the seller with user id 'S3AB0' for each category of item where they've had sales. Print the item_id, item_name, category, and price of these highest-price items.  Rank the output by price from highest to lowest.
SELECT I1.item_id, I1."name", I1.category, I1.price
FROM cs222p_interchange.item I1
INNER JOIN (
	SELECT MAX(I.price) as hprice, I.category
	FROM cs222p_interchange.item I
	WHERE I.seller_user_id = 'S3AB0'  --AND I.buyer_user_id IS NOT NULL
	GROUP BY I.category) tmp ON tmp.hprice = I1.price AND tmp.category = I1.category
ORDER BY I1.price DESC

--For all unpurchased services that had an ad placed by its seller, list the seller's user_id and the item_id, item_name, price, category, ad_id, ad_plan, and number of pictures associated with the item. Limit your output to the top 10 results ordered from highest to lowest by price.
SELECT I.seller_user_id, I.item_id, I."name", I.price, I.category, ad.ad_id, ad.plan, tmp.cnt
FROM cs222p_interchange.item I
INNER JOIN cs222p_interchange.service ON service.item_id = I.item_id AND I.buyer_user_id IS NULL
INNER JOIN cs222p_interchange.ad ON ad.item_id = I.item_id AND ad.seller_user_id = I.seller_user_id
INNER JOIN (
	SELECT pic.item_id, COUNT(*) AS cnt
	FROM cs222p_interchange.picture pic
	GROUP BY pic.item_id
) tmp ON tmp.item_id = I.item_id
ORDER BY I.price DESC
LIMIT 10
