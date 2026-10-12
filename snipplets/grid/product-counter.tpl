{% set products_on_page = products | length %}
{% set first_product = (products_on_page * pages.current) - products_on_page + 1 %}
{% set last_product = products_on_page * pages.current %}

{% if pages.current == 1 %}
    {% set first_product = 1 %}
{% endif %}

<div class="product-count">
    <span>
        {% if first_product == 1 and last_product == 1 %}
            {{ 'Mostrando 1 producto' | translate }}
        {% else %}
            {{ 'Mostrando' | translate }} {% if settings.pagination == 'classic' %}{{ first_product }}-{{ last_product }} {{ 'de ' | translate }}{% endif %}{{ products_count }} {{ 'productos' | translate }}
        {% endif %}
    </span>
</div>