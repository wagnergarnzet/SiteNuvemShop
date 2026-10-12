{% if custom_payments %}
	{% set visa = settings.payment_visa %}
	{% set mastercard = settings.payment_mastercard %}
	{% set amex = settings.payment_amex %}
	{% set diners = settings.payment_diners %}
	{% set mercadopago = settings.payment_mercadopago %}
	{% set paypal = settings.payment_paypal %}

	{% if visa %}
		{% set payment = "visa" %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="icon-logo lazyload" alt="{{ payment }}">
	{% endif %}
	{% if mastercard %}
		{% set payment = "mastercard" %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="icon-logo lazyload" alt="{{ payment }}">
	{% endif %}
	{% if amex %}
		{% set payment = "amex" %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="icon-logo lazyload" alt="{{ payment }}">
	{% endif %}
	{% if diners %}
		{% set payment = "diners" %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="icon-logo lazyload" alt="{{ payment }}">
	{% endif %}
	{% if mercadopago %}
		{% set payment = "mercadopago" %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="icon-logo lazyload" alt="{{ payment }}">
	{% endif %}
	{% if paypal %}
		{% set payment = "paypal" %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/paypal@2x.png' | static_url }}" class="icon-logo lazyload" alt="{{ payment }}">
	{% endif %}
{% elseif payments %}
	{% for payment in settings.payments %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ payment | payment_new_logo }}" class="icon-logo lazyload" alt="{{ payment }}">
	{% endfor %}
{% elseif shipping %}
	{% for shipping in settings.shipping %}
		<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ shipping | shipping_logo }}" class="icon-logo lazyload" alt="{{ shipping }}">
    {% endfor %}
{% endif %}