{% if product_detail %}
	
	{# Wording to notice that adding one more product free shipping is achieved #}

	{% if calculator_label %}
	<div class="js-shipping-add-product-label box-shipping box-accent" {% if hide_free_shipping_minimum %}style="display: none;"{% endif %}>
	{% else %}
	<div class="js-free-shipping-add-product-title position-absolute transition-up w-100 {% if not hide_free_shipping_minimum %}transition-up-active{% endif %} font-small mb-3 box-shipping box-accent">
	{% endif %}
		<span class='js-fs-add-this-product'>{{ "¡Agregá este producto y " | translate }}</span>
		<span class='js-fs-add-one-more' style='display: none;'>{{ "¡Agregá uno más y " | translate }}</span>
		<strong>{{ "tenés envío gratis!" | translate }}</strong>
	</div>

{% elseif settings.show_progressbar %}
	{{ component('free-shipping-bar', {
		progress_bar_classes: {
			container: 'js-ship-free-rest progress-bar mt-2 mb-3',
			title_container: 'progress-bar-title-container',
			title: 'js-ship-free-rest-message ship-free-rest-message progress-bar-title',
			icon: 'progress-bar-icon icon-inline icon-lg',
			track: 'bar-progress',
			fill: 'bar-progress-active transition-soft',
			check: 'bar-progress-check transition-soft',
			check_icon: 'icon-inline',
		},
		progress_bar_icon_svg_id: 'truck',
		check_svg_id: 'check',
		show_check: true,
	}) }}
{% endif %}
