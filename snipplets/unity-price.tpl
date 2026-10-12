{% set quantity_variation = ['cantidad','quantidade','quantity'] %}

{% if product.variations %}
    {% for variation in product.variations %}
        {% if variation.name|lower in quantity_variation %}
            <p class="price-unit font-small mb-0"> 
                <span class="js-price-unit">
                {% for option in variation.options|slice(0, 1) %}
                    {% set price_unit = product.price / option.id %}
                    {{ price_unit | money }}
                {% endfor %}
                </span>
                {{ 'por unidad' | translate }}
            </p>
        {% endif %}
    {% endfor %}
{% endif %}
