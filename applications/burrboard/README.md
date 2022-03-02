Create (read) user:

```sql
CREATE USER dashboard;
ALTER USER dashbaord WITH PASSWORD 'reader-password';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO dashboard;
```

Create (pusher) user:

```sql
CREATE USER pusher;
ALTER USER pusher WITH PASSWORD 'pusher-password';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO pusher;
```

Create the table:

```sql
CREATE TABLE temperatures (
    time TIMESTAMP WITH TIME ZONE NOT NULL,

    device_id VARCHAR(64) NOT NULL,

    temperature DOUBLE PRECISION NOT NULL,
    humidity DOUBLE PRECISION,
    battery DOUBLE PRECISION,

    lon NUMERIC,
    lat NUMERIC
);

SELECT create_hypertable('temperatures', 'time', 'device_id', 2);
```