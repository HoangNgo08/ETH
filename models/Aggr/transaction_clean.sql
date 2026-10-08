{{
    config(
        materialized='incremental',
        strategy='append',
        on_schema_change='fail'
    )
}}

select 
    t.hash,
    t.block_number,
    t.DATE as transaction_date,
    t.from_address,
    t.to_address,
    t.value,
    t.receipt_contract_address,
    t.input,
    tt.token_trasnfer_count,
    case
        when t.receipt_contract_address != '' then 'contract_creation'
        when tt.transaction_hash is not null then 'token_transfer'
        when t.input = '0x' and t.value > 0 then 'plain_eth_transfer'
        else 'other'
    end as transcation_category
from {{ref('stg_transactions')}} t
left join (
    select
        transaction_hash,
        count(*) as token_trasnfer_count
    from {{ref('stg_token_transfers')}}
    group by transaction_hash
    ) tt
on t.hash = tt.transaction_hash


{% if is_incremental() %}
    where transaction_date >= (select max(transaction_date) from {{this}})
{% endif%}