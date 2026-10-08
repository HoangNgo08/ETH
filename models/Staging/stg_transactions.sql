{{
    config(materialized='incremental',
    strategy='merge',
    unique_key='hash'
    )
}}

select * from {{source('ETH','TRANSACTIONS')}}

{% if is_incremental() %}
    where date >= (select max(date) from {{this}})
{% endif %}