{% set variant_url = '' %}
{% set default_variant_url = '' %}
{% set available_variant_url = '' %}
{% set default_available_variant_url = '' %}
{% set size_available = false %}

{% for variant in product.variants_object %}
    {% if variant[variant_size] == option.name %}
        {% if not variant_url %}
            {% set variant_url = '?variant=' ~ variant.id %}
        {% endif %}
        {% if variation_color and variant[variant_color] == default_color and not default_variant_url %}
            {% set default_variant_url = '?variant=' ~ variant.id %}
        {% endif %}
        {% if variant.available %}
            {% if not available_variant_url %}
                {% set available_variant_url = '?variant=' ~ variant.id %}
            {% endif %}
            {% if (not variation_color or variant[variant_color] == default_color) and not default_available_variant_url %}
                {% set default_available_variant_url = '?variant=' ~ variant.id %}
            {% endif %}
            {% set size_available = true %}
        {% endif %}
    {% endif %}
{% endfor %}

{% if default_available_variant_url %}
    {% set variant_url = default_available_variant_url %}
{% elseif available_variant_url %}
    {% set variant_url = available_variant_url %}
{% elseif default_variant_url %}
    {% set variant_url = default_variant_url %}
{% endif %}

<a href="{{ product.url }}{{ variant_url }}" class="item-size item-sizes-bullet{% if not size_available %} item-sizes-bullet-no-stock{% endif %}" data-value="{{ option.name }}"{% if not size_available %} aria-label="{{ option.name }} - {{ 'Sin stock' | translate }}"{% endif %}>
    <span>{{ option.name }}</span>
</a>
