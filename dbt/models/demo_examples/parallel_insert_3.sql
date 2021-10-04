{{ 
    config(
        materialized='parallel_insert',
        target_table='parallel_insert_target',
        warehouse='MATT_W_PARALLEL_INSERT_TEST_WH_3'
    )
}}

{% for i in range(0,100) %}
   {% if not loop.last %}
    select order_key, order_date from {{ ref('fct_order_items') }} where order_date between '1996-01-01' and '1997-12-31'
    union all
   {% else %}
     select order_key, order_date from {{ ref('fct_order_items') }} where order_date between '1996-01-01' and '1997-12-31'
   {% endif %}
{% endfor %}

