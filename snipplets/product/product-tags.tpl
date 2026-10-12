{% set seal_tag = [] %}
{% for seal in settings.custom_seals %}
	{% for tag in product.tags %}
		{% if tag == seal.title %}
			{% set seal_tag = seal_tag|merge([tag]) %}
		{% endif %}
	{% endfor %}
{% endfor %}

<div class="product-tags {% if not settings.product_tags %}d-none{% endif %}">
    {% for tag in product.tags %}
        {% if tag not in seal_tag and tag != settings.product_terms_tag %}
            <span>{{ tag }}</span>
        {% endif %}
    {% endfor %}
</div>