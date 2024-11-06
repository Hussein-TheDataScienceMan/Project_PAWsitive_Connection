ALTER TABLE blw_avg_stayed_pets
ADD COLUMN stay_period_from_avg Varchar


UPDATE blw_avg_stayed_pets
SET stay_period_from_avg = 'Below Avg'