{% set has_product_available = product.available and product.display_price %}
{% set group_label_classes = product.video_url and product_detail ? 'js-labels-group labels' : 'labels' %}
{% set promotion_label_classes = 'js-offer-label label label-accent' %}
{% set offer_label_classes = promotion_label_classes %}
{% set shipping_label_classes = 'label label-accent free-shipping' ~ (product.free_shipping ? '' : ' js-free-shipping-minimum-label') %}
{% set no_stock_label_classes = 'js-stock-label label label-default label-stock' %}

{% set last_product_label %}
	{% if product_detail %}
		{% if settings.last_product and has_product_available %}
			<div class="{% if product.variations %}js-last-product {% endif %}label label-default"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
				{{ settings.last_product_text }}
			</div>
		{% endif %}
	{% else %}
		{% if settings.last_product and has_product_available and settings.last_product_card %}
			<div class="{% if product.variations %}js-last-product {% endif %}label label-default"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
				{{ settings.last_product_text }}
			</div>
		{% endif %}
	{% endif %}
{% endset %}

{{ component(
	'labels', {
		prioritize_promotion_over_offer: true,
		promotion_quantity_long_wording: true,
		promotion_nxm_long_wording: false,
		group_data_store: true,
		offer_negative_discount_percentage: false,
		labels_classes: {
			group: group_label_classes,
			promotion: promotion_label_classes,
			promotion_primary_text: 'd-block',
			offer: offer_label_classes,
			shipping: shipping_label_classes,
			no_stock: no_stock_label_classes,
		},
		labels_custom_content: last_product_label|trim,
	})
}}

<span class="hidden" data-store="stock-product-{{ product.id }}-{% if product.has_stock %}{% if product.stock %}{{ product.stock }}{% else %}infinite{% endif %}{% else %}0{% endif %}"></span>
