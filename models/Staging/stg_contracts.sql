
-- {{config(materialized='view')}}

select * from {{source('ETH','CONTRACTS')}}