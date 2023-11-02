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