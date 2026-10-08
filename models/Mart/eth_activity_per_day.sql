select
    transaction_date,
    transcation_category,
    count(*) as tx_count,
    {{conversion('value','1e18')}} as sum_eth_value
from {{ ref('transaction_clean')}}
group by
    transaction_date,
    transcation_category