{% set icon_map = {
  'shipping': 'truck',
  'cart': 'shopping-cart',
  'card': 'credit-card',
  'security': 'security',
  'returns': 'returns',
  'whatsapp': 'whatsapp-lines',
  'promotions': 'tag',
  'barcode': 'barcode'
} %}

{% set adbars = ['ad_bar_01', 'ad_bar_02', 'ad_bar_03', 'ad_bar_04'] %}
{% set items = [] %}

{% for key in adbars %}
  {% set text = attribute(settings, key ~ '_text') %}
  {% if text %}
    {% set items = items|merge([{
      'text': text,
      'url': attribute(settings, key ~ '_url'),
      'icon_key': attribute(settings, key ~ '_icon')
    }]) %}
  {% endif %}
{% endfor %}

{% set num_ad = items|length %}

{% if num_ad > 0 %}
{% set adbar_effect = settings.adbar_carousel ? (settings.adbar_animation_type ?: 'carousel') : 'none' %}

{% macro render_ad_item(item, icon_map) %}
  {% set icon = (item.icon_key is not empty and item.icon_key != 'none') ? icon_map[item.icon_key] : null %}

  {% if item.url %}
    <a href="{{ item.url }}" class="adbar-item">
  {% else %}
    <div class="adbar-item">
  {% endif %}

    {% if icon is not empty %}
      <svg class="icon-inline adbar-icon"><use xlink:href="#{{ icon }}"/></svg>
    {% endif %}
    <div class="adbar-text">{{ item.text }}</div>

  {% if item.url %}
    </a>
  {% else %}
    </div>
  {% endif %}
{% endmacro %}

{% import _self as adbar %}

<section class="js-adbar section-adbar{% if adbar_effect == 'marquee' %} section-adbar-marquee{% endif %}">
    {% if adbar_effect == 'marquee' %}
      {% if num_ad == 1 %}
        {% set repeat_number = 16 %}
      {% elseif num_ad == 2 %}
        {% set repeat_number = 8 %}
      {% else %}
        {% set repeat_number = 5 %}
      {% endif %}
      <div class="js-adbar-animated adbar-animated adbar-marquee">
        <div class="js-adbar-text-container adbar-marquee-track">
          {% for i in 1..repeat_number %}
            {% for item in items %}
              {{ adbar.render_ad_item(item, icon_map) }}
            {% endfor %}
          {% endfor %}
        </div>
      </div>
    {% else %}
		<div class="container position-relative">
			<div class="js-swiper-adbar swiper-adbar {% if num_ad > 1 %}swiper{% endif %}">
				<div class="{% if num_ad > 1 %}swiper-wrapper{% endif %}">
					{% for item in items %}
					{% if num_ad > 1 %}<div class="swiper-slide">{% endif %}
						{{ adbar.render_ad_item(item, icon_map) }}
					{% if num_ad > 1 %}</div>{% endif %}
					{% endfor %}
				</div>
			</div>
			{% if num_ad > 1 %}
				<div class="js-swiper-adbar-prev swiper-button-prev swiper-adbar-control">
					<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
				</div>
				<div class="js-swiper-adbar-next swiper-button-next swiper-adbar-control">
					<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
				</div>
			{% endif %}
		</div>
    {% endif %}
</section>
{% endif %}
