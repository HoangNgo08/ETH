{% macro conversion(col_name,value) %}
    sum({{col_name}})/ {{value}}
{% endmacro %}