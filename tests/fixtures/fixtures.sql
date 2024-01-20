CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO "tmp_user" (id, name, username, password_hash, created_at, updated_at)
VALUES
    ('8d2407fa-3ddc-4304-a7c8-0880af86bd14', 'admin', 'admin@somemail.com', '$2a$12$w81xZx5ZLtI6Vur/qqYSW.VAXdyiKbwaRbRNd9YDhh73pea/1ZD36', 1668504671, 1668504671);
