-- HW7
--Now create secondary indexes on the item.category, item.price, user.first_name, and ad.plan fields separately. (I.e., create four indexes.) Paste your CREATE INDEX statements below.
CREATE INDEX idx_item_category ON cs222p_interchange.item (category);
CREATE INDEX idx_item_price ON cs222p_interchange.item (price);
CREATE INDEX idx_user_first_name ON cs222p_interchange.user (first_name);
CREATE INDEX idx_ad_plan ON cs222p_interchange.ad (plan);

CREATE INDEX rating_idx ON cs222p_interchange.ratings (quality, pricing, delivery);


CREATE INDEX rating_quality ON cs222p_interchange.ratings (quality);
CLUSTER cs222p_interchange.ratings USING rating_quality;

CREATE INDEX ad_plan ON cs222p_interchange.ad (plan);
CLUSTER cs222p_interchange.ad USING ad_plan;
Again, we are selecting the entire row. Clustering the index will be useful
