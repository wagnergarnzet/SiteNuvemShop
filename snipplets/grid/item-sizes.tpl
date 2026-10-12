{% if product.variations %}
    {% set variant_size = '' %}
    {% set variant_color = '' %}
    {% set default_color = '' %}
    {% set variation_color = false %}
    {% set variation_size = false %}
    {% set has_invalid_variation = false %}
    {% set size_variants = 0 %}

    {% for variation in product.variations %}

        {% if variation.name|lower in ['color', 'cor'] %}
            {% set variation_color = true %}
            {% set variant_color = 'option' ~ loop.index0 %}
        {% elseif variation.name|lower matches '/(talle|talla|tamanho|size)/' %}
            {% set variation_size = true %}
            {% set variant_size = 'option' ~ loop.index0 %}
        {% else %}
            {% set has_invalid_variation = true %}
        {% endif %}
    {% endfor %}

    {% for variation in product.variations if variation.name|lower in ['color', 'cor'] %}
        {% set default_color = variation.options[0].name %}
    {% endfor %}

    {# Show "One size" if there's no size variation #}
    {% if settings.product_one_size and not variation_size %}
        <div class="item-sizes">
            <a href="{{ product.url }}" class="item-size item-sizes-bullet" data-value="">
                <span>{{ 'Único' | translate }}</span>
            </a>
        </div>
    {% endif %}

    {# Displays only sizes (and ignores any other variation) #}
    {% for variation in product.variations if variation.name|lower matches '/(talle|talla|tamanho|size)/' %}
        {% if variation.options | length > 1 %}
            {% for option in variation.options %}
                {% set size_variants = size_variants + 1 %}
            {% endfor %}

            {% if size_variants > 4 %}
                {% set take_length = 3 %}
            {% else %}
                {% set take_length = 4 %}
            {% endif %}

            <div class="item-sizes">
                {% for option in variation.options | take(take_length) %}
                    {% include 'snipplets/grid/item-size-bullet.tpl' %}
                {% endfor %}

                {% if size_variants > 4 %}
                    <a href="{{ product.url }}" class="item-size item-sizes-bullet">
                        + {{ size_variants - 3 }}
                    </a>
                {% endif %}
            </div>

        {% elseif variation.options | length == 1 %}
            {% set option = variation.options[0] %}
            <div class="item-sizes">
                {% include 'snipplets/grid/item-size-bullet.tpl' %}
            </div>
        {% endif %}
    {% endfor %}
{% elseif settings.product_one_size %}
    <div class="item-sizes">
        <a href="{{ product.url }}" class="item-size item-sizes-bullet" data-value="">
            <span>{{ 'Único' | translate }}</span>
        </a>
    </div>
{% endif %}
