{% if settings.seal_limit %}
	{% set num_seal = 0 %}
{% endif %}

{% if settings.seal_limit %}
	<div class="seals{% if settings.seals_position == 'top-left' %} item-seals{% else %} text-center d-flex align-items-center justify-content-center{% endif %}">
		{% for seal in settings.custom_seals %}
			{% for tag in product.tags %}
				{% if seal.title == tag and num_seal < settings.seal_limit %}
					{% set num_seal = num_seal + 1 %}
					<div class="seal{% if not settings.seals_position == "top-left" and settings.seal_limit > 1 %} p-1{% endif %}">
						{% if seal.link %}<a class="seal-link" href="{{ seal.link }}">{% endif %}
							<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ seal.image | static_url | settings_image_url('small') }} 240w" data-sizes="auto" class="lazyautosizes lazyload" title="{{ seal.description }}" alt="{{ seal.description }}" {% if settings.seal_height != "" %}height="{{ settings.seal_height }}"{% else %}height="30"{% endif %}/>							
						{% if seal.link %}</a>{% endif %}
					</div>
				{% endif %}
			{% endfor %}
		{% endfor %}
	</div>
{% else %}
	<div class="seals{% if settings.seals_position == 'top-left' %} item-seals{% else %} text-center d-flex align-items-center justify-content-center{% endif %}">
		{% for seal in settings.custom_seals %}
			{% for tag in product.tags %}
				{% if seal.title == tag %}
					{% set num_seal = num_seal + 1 %}
					<div class="seal{% if not settings.seals_position == "top-left" %} p-1{% endif %}">
						{% if seal.link %}<a class="seal-link" href="{{ seal.link }}">{% endif %}
							<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ seal.image | static_url | settings_image_url('small') }} 240w" data-sizes="auto" class="lazyautosizes lazyload" title="{{ seal.description }}" alt="{{ seal.description }}" {% if settings.seal_height != "" %}height="{{ settings.seal_height }}"{% else %}height="30"{% endif %}/>
						{% if seal.link %}</a>{% endif %}
					</div>
				{% endif %}
			{% endfor %}
		{% endfor %}
	</div>
{% endif %}
