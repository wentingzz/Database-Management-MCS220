--create views
CREATE OR REPLACE VIEW SellerOverallRating (seller_id, overall_rating, classification, valid_rating_count)
AS
WITH overall AS (
	SELECT r.seller_id,
		(SUM(COALESCE(r.quality, 2.5)) +
		SUM(COALESCE(r.delivery, 2.5)) +
		SUM(COALESCE(r.pricing, 2.5)))/COUNT(*)/3 as overall_rating,
		SUM(CASE WHEN i.item_id IS NULL THEN 0 ELSE 1 END) as valid_rating_count
	FROM cs222p_interchange.ratings r
	LEFT OUTER JOIN cs222p_interchange.item i
	ON r.buyer_id = i.buyer_user_id AND r.seller_id = i.seller_user_id
	GROUP BY r.seller_id
)
SELECT o.seller_id, o.overall_rating,
(CASE
	WHEN o.overall_rating >= 4.4 THEN 'High'
	WHEN o.overall_rating >=2.6 THEN 'Medium'
	WHEN o.overall_rating <2.6 THEN 'Underdog'
END) as classification, o.valid_rating_count
FROM overall o;

SELECT sor.seller_id, u.first_name, u.last_name, s.website, sor.classification, sor.valid_rating_count
FROM SellerOverallRating sor, cs222p_interchange.user u, cs222p_interchange.seller s
WHERE sor.seller_id = u.user_id AND sor.seller_id = s.user_id
ORDER BY sor.valid_rating_count DESC
LIMIT 5

--5. Stored Procedures [20 pts]
CREATE PROCEDURE InsertServiceAndPlaceAd(
	IN seller_user_id text,
	IN item_name text,
	IN item_id text,
	IN service_frequency cs222p_interchange.Frequency,
	IN price float,
	IN category text,
	IN description text,
	IN ad_id text,
	IN plan text,
	IN content text,
	IN picture_url text,
	IN picture_format cs222p_interchange.PictureFormat
)

LANGUAGE plpgsql
AS $$
DECLARE
pic_number INTEGER := 1;
BEGIN

	IF NOT EXISTS (SELECT * FROM cs222p_interchange.item i WHERE i.item_id = InsertServiceAndPlaceAd.item_id) THEN
		INSERT INTO cs222p_interchange.item(item_id,name,price,category,description,seller_user_id, list_date)
		VALUES (item_id, item_name, price, category, description, seller_user_id, CURRENT_DATE);
	END IF;

	INSERT INTO cs222p_interchange.service (item_id, frequency)
	VALUES (item_id, service_frequency);

	IF EXISTS(SELECT * FROM cs222p_interchange.picture pic WHERE pic.item_id = InsertServiceAndPlaceAd.item_id) THEN
		SELECT MAX(pic_num) + 1 INTO pic_number
		FROM cs222p_interchange.picture pic
		WHERE pic.item_id = item_id;
	END IF;

	INSERT INTO cs222p_interchange.picture (pic_num, item_id, format, url)
	VALUES (pic_number, item_id, picture_format, picture_url);

	INSERT INTO cs222p_interchange.ad (ad_id, plan, content, pic_num, item_id, seller_user_id, placed_date)
	VALUES (ad_id, plan, content, pic_number, item_id, seller_user_id, CURRENT_DATE);
END;
$$

