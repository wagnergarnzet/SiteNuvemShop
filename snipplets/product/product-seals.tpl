{% set seals_count = 0 %}
{% set seal_desktop = settings.seal_description_position_desktop %}
{% set seal_mobile = settings.seal_description_position_mobile %}

{% set seal_classes = 
  (seal_mobile == "bottom" ? "flex-column mb-3" : "flex-row") ~ " " ~
  (seal_desktop == "bottom" ? "flex-md-column mb-0" : "flex-md-row")
%}

{% for seal in settings.custom_seals %}
	{% for tag in product.tags %}
		{% if seal.title == tag %}
			{% set seals_count = seals_count + 1 %}
		{% endif %}
	{% endfor %}
{% endfor %}
{% if settings.show_custom_seals and seals_count %}
	<div class="seals product-seals mb-4">
		{% if settings.seal_title and seals_count %}
		<div class="row">
			<h3 class="col-12 mt-4 text-center">{{ settings.seal_title }}</h3>
		</div>
		{% endif %}
		<div class="row justify-content-center">
		{% for seal in settings.custom_seals %}
			{% for tag in product.tags %}
				{% if seal.title == tag %}
					<div class="col-6 col-md-auto seal d-inline-flex {{ seal_classes }} align-items-center justify-content-start">
						{% if seal.link %}<a class="seal-link" href="{{ seal.link }}">{% endif %}
							<img src="{{ seal.image | static_url | settings_image_url('original') }}" title="{{ seal.description }}" alt="{{ seal.description }}" {% if settings.seal_height != "" %}style="height: calc({{ settings.seal_height }}px*2); width: auto;"{% else %}height = "60"{% endif %} />
						{% if seal.link %}</a>{% endif %}
						{% if settings.show_seal_description %}
							<div class="mt-{{ seal_mobile == "bottom" ? '2 text-center' : '0 text-left' }} mt-md-{{ seal_desktop == "bottom" ? '2 text-md-center' : '0 text-md-left' }} mx-2 pl-md-2">
								{{ seal.description }}
							</div>
						{% endif %}
					</div>
				{% endif %}
			{% endfor %}
		{% endfor %}
		</div>
	</div>
{% endif %}