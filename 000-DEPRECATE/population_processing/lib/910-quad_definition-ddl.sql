begin;


-- Register grids

delete from meta.grid;

select cell__registergrid(
    'eu-grid',
    st_setsrid(st_makepoint(2700000, 1500000), 3035),
    '{
        "0": {"name": "100 km", "size": 100000},
        "1": {"name": "50 km", "size": 50000},
        "2": {"name": "10 km", "size": 10000},
        "3": {"name": "5 km", "size": 5000},
        "4": {"name": "1 km", "size": 1000},
        "5": {"name": "500 m", "size": 500},
        "6": {"name": "250 m", "size": 250},
        "7": {"name": "125 m", "size": 125},
        "8": {"name": "62.5 m", "size": 62.5},
        "9": {"name": "31.25 m", "size": 31.25},
        "10": {"name": "15.625 m", "size": 15.623},
        "11": {"name": "7.8125 m", "size": 7.8125}
    }'::jsonb
);

commit;


