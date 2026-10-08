select {{ dbt_utils.star(from = ref("stg_contracts") )}}
from {{ ref("stg_contracts") }}