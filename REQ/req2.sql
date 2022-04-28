-- Liste les bateaux ayant réalisé au moins 2 voyages ainsi que la moyenne des volumes transporter par voyage

SELECT
    ship_id,
    AVG(volume_shipment)
FROM
    ships
    NATURAL JOIN (
        SELECT
            shipment_id,
            ship_id,
            SUM(A.volume_cargo) AS volume_shipment
        FROM
            shipments
            NATURAL JOIN (
                SELECT
                    shipment_id,
                    cargo_id,
                    ((quantity * volume) + 0.0) AS volume_cargo
                FROM
                    cargo
                    NATURAL JOIN products) AS A
            GROUP BY
                shipment_id,
                ship_id) AS B
GROUP BY
    ship_id
HAVING
    COUNT(shipment_id) > 1;