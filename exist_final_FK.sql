

-- FOREIGN KEYS
USE existru;

-- profile FK
ALTER TABLE existru.profiles ADD CONSTRAINT profiles_FK FOREIGN KEY (client_id) REFERENCES existru.users(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.profiles ADD CONSTRAINT profiles_FK_1 FOREIGN KEY (price_level) REFERENCES existru.pricings(id) ON UPDATE CASCADE;
-- users
ALTER TABLE existru.users ADD CONSTRAINT users_FK FOREIGN KEY (home_region) REFERENCES existru.regions(region_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.users ADD CONSTRAINT users_FK_1 FOREIGN KEY (main_adress) REFERENCES existru.users_adresses(id) ON UPDATE CASCADE;
ALTER TABLE existru.users ADD CONSTRAINT users_FK_2 FOREIGN KEY (photo_id) REFERENCES existru.media_content(id) ON DELETE CASCADE ON UPDATE CASCADE;
-- media to mediatypes
ALTER TABLE existru.media_content ADD CONSTRAINT media_content_FK FOREIGN KEY (media_type_id) REFERENCES existru.media_types(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.media_content ADD CONSTRAINT media_content_FK_1 FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- alerts to alert type
ALTER TABLE existru.alerts ADD CONSTRAINT alerts_FK FOREIGN KEY (alert_type) REFERENCES existru.alert_types(alerts_type_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.alerts ADD CONSTRAINT alerts_FK_1 FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id) ON DELETE CASCADE ON UPDATE CASCADE;
-- social FK
ALTER TABLE existru.social_network_passports ADD CONSTRAINT social_network_passport_FK FOREIGN KEY (social_net) REFERENCES existru.social_nets(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.social_network_passports ADD CONSTRAINT social_network_passport_FK_1 FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.social_nets ADD CONSTRAINT social_net_FK FOREIGN KEY (network_icon) REFERENCES existru.media_content(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- comments
ALTER TABLE existru.users_comments ADD CONSTRAINT user_comments_FK FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id) ON DELETE CASCADE ON UPDATE CASCADE;
-- garage
ALTER TABLE existru.garage ADD CONSTRAINT garage_FK FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE existru.garage ADD CONSTRAINT garage_FK_1 FOREIGN KEY (media_attached) REFERENCES existru.media_content(id) ON DELETE CASCADE ON UPDATE CASCADE;
-- requests
ALTER TABLE existru.requests ADD CONSTRAINT requests_FK FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id) ON UPDATE CASCADE;
ALTER TABLE existru.requests ADD CONSTRAINT requests_FK_1 FOREIGN KEY (for_car_id) REFERENCES existru.garage(vehicle_id) ON UPDATE CASCADE;
ALTER TABLE existru.requests ADD CONSTRAINT requests_FK_2 FOREIGN KEY (media_attached) REFERENCES existru.media_content(id) ON DELETE CASCADE ON UPDATE CASCADE;
-- orders
ALTER TABLE existru.orders ADD CONSTRAINT orders_FK FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.orders ADD CONSTRAINT orders_FK_1 FOREIGN KEY (delivery_adress) REFERENCES existru.users_adresses(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE existru.orders ADD CONSTRAINT orders_FK_2 FOREIGN KEY (for_car_id) REFERENCES existru.garage(vehicle_id) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE existru.orders ADD CONSTRAINT orders_FK_3 FOREIGN KEY (request_number) REFERENCES existru.requests(request_id) ON DELETE CASCADE ON UPDATE CASCADE;
-- adresses 
ALTER TABLE existru.users_adresses ADD CONSTRAINT user_adress_FK FOREIGN KEY (user_id) REFERENCES existru.profiles(client_id);

















