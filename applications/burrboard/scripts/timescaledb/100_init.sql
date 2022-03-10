CREATE TABLE devices
(
    time            TIMESTAMP WITH TIME ZONE NOT NULL,

    device_id       VARCHAR(64)              NOT NULL,

    temperature     DOUBLE PRECISION         NOT NULL,
    light           DOUBLE PRECISION         NOT NULL,

    button_a        INTEGER                  NOT NULL,
    button_b        INTEGER                  NOT NULL,

    accelerometer_x DOUBLE PRECISION,
    accelerometer_y DOUBLE PRECISION,
    accelerometer_z DOUBLE PRECISION,

    battery         DOUBLE PRECISION
);

SELECT create_hypertable('devices', 'time');
