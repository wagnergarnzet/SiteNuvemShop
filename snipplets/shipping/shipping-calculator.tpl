{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set shipping_best_discount = cart.free_shipping.min_price_free_shipping %}
{% set is_full_free_shipping = shipping_best_discount.is_free or not shipping_best_discount.discount_type %}

{# Free shipping visibility variables #}

{% if product_detail and cart.free_shipping.min_price_free_shipping.min_price %}

	{# Calculate if adding one more product free shipping is achieved #}

	{% set free_shipping_product_threashold = cart.free_shipping.min_price_free_shipping.min_price_raw - (cart.total + product.price) %}

	{% set hide_free_shipping_minimum = (cart.free_shipping.cart_has_free_shipping or not cart.free_shipping.min_price_free_shipping.min_price) or free_shipping_product_threashold <= 0 %}

{% else %}

	{% set hide_free_shipping_minimum = cart.free_shipping.cart_has_free_shipping or not cart.free_shipping.min_price_free_shipping.min_price %}

{% endif %}

{% set free_shipping_minimum_label_changes_visibility = product_detail and has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{% set free_shipping_messages_visible = (product_detail and has_free_shipping) or (not product_detail and has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw == 0) %}

{% set hide_cart_free_shipping_message = not product_detail and has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 and product_detail %}

{% if product_detail %}
	{% set cart_zipcode = false %}
{% else %}
	{% set cart_zipcode = cart.shipping_zipcode %}
{% endif %}

{% if shipping_calculator_show %}
<div class="js-accordion-private-container js-toggle-shipping shipping-calculator mb-2">
    <a href="#" class="js-accordion-private-toggle p-3 row no-gutters align-items-center">
        <div class="col">
            <div class="m-0 h6 text-uppercase">
            	<svg class="icon-inline icon-lg svg-icon-text mr-1"><use xlink:href="#truck"/></svg>
            	{{ 'Medios de envío' | translate }}
            </div>
        </div>
        <div class="col-auto">
			{% if settings.shipping_calculator_layout == "closed" %}
				<span class="js-accordion-private-toggle-inactive">
					<svg class="icon-inline svg-icon-text"><use xlink:href="#plus"/></svg>
				</span>
				<span class="js-accordion-private-toggle-active" style="display: none;">
					<svg class="icon-inline svg-icon-text"><use xlink:href="#minus"/></svg>
				</span>
			{% else %}
				<span class="js-accordion-private-toggle-active" style="display: none;">
					<svg class="icon-inline svg-icon-text"><use xlink:href="#plus"/></svg>
				</span>
				<span class="js-accordion-private-toggle-inactive">
					<svg class="icon-inline svg-icon-text"><use xlink:href="#minus"/></svg>
				</span>
			{% endif %}
        </div>
    </a>
	{% set branches_outside_calculator = store.branches and not store.has_shipping_segmentation %}
	<div class="js-accordion-private-content px-3 pb-3" {% if settings.shipping_calculator_layout == "closed" %}style="display: none;"{% endif %}>
		<div class="text-left {% if product_detail %}product-shipping-calculator{% endif %} w-100" data-store="shipping-calculator">

			{# Check if store has free shipping without regions or categories #}

			{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

			<div class="js-shipping-calculator-head shipping-calculator-head position-relative transition-soft {% if cart.shipping_zipcode %}with-zip{% else %}with-form{% endif %} {% if has_free_shipping %}with-free-shipping{% endif %}">
			
				<div class="js-shipping-calculator-with-zipcode {% if cart.shipping_zipcode %}js-cart-saved-zipcode transition-up-active{% endif %} mb-4 w-100 transition-up position-absolute">
					<div class="row px-3">
						<div class="col shipping-calculator-current-zip font-small">
							{{ "Entregas para el CP:" | translate }} <strong class="js-shipping-calculator-current-zip pl-1">{{ cart.shipping_zipcode }}</strong>
						</div>
						<div class="col-4 pr-0">
							<a class="js-shipping-calculator-change-zipcode btn btn-default btn-small w-100" href="#">{{ "Cambiar CP" | translate }}</a>
						</div>
					</div>
				</div>

				<div class="js-shipping-calculator-form mb-2 transition-up position-absolute w-100">

					{# Shipping calculator input #}
					
					{% embed "snipplets/forms/form-input.tpl" with{type_tel: true, input_value: cart_zipcode, input_name: 'zipcode', input_custom_class: 'js-shipping-input d-block', input_placeholder: "Tu código postal" | translate, input_aria_label: 'Tu código postal' | translate, input_label: false, input_append_content: true, input_group_custom_class: 'mb-3'} %}
						{% block input_prepend_content %}
							
							{# Free shipping with min price label #}

							<div class="{% if free_shipping_minimum_label_changes_visibility %}js-shipping-calculator-label{% endif %} shipping-calculator-label box-shipping box-accent" {% if hide_free_shipping_minimum or hide_cart_free_shipping_message %}style="display: none;"{% endif %}>
								{% if is_full_free_shipping %}
									{{ "<strong>Envío gratis</strong> superando los" | translate }}
								{% else %}
									{% set shipping_discount = shipping_best_discount.discount_type == 'percentage'
										? (shipping_best_discount.discount_value | round) ~ '%'
										: shipping_best_discount.discount_value_money
									%}
									<strong>{{ shipping_discount }} {{ 'our_components.free_shipping_bar.off_shipping' | tt }}</strong> {{ "superando los" | translate }}
								{% endif %}
								<span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
							</div>

							{% if include_product_free_shipping_min_wording and is_full_free_shipping %}

								{% include "snipplets/shipping/shipping-free-rest.tpl" with {'calculator_label': true, 'product_detail': true} %}

							{% endif %}

							{# Free shipping achieved calculator label #}

							{% if is_full_free_shipping %}
								<div class="{% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} free-shipping-message box-shipping box-success" {% if not cart.free_shipping.cart_has_free_shipping or hide_cart_free_shipping_message %}style="display: none;"{% endif %}>
									{{ "<strong>¡Genial!</strong> Tenés envío gratis" | translate }}
								</div>
							{% endif %}

							<div class="position-relative form-row m-0 mt-2">
								<div class="col p-0">
						{% endblock input_prepend_content %}
						{% block input_append_content %}
								</div>
								<div class="col-auto pl-2 pr-0">
									<button class="js-calculate-shipping btn btn-default d-flex justify-content-center align-items-center font-small" aria-label="{{ 'Calcular envío' | translate }}">	
										<span class="js-calculate-shipping-wording text-uppercase">{{ "Calcular" | translate }}</span>
										<span class="js-calculating-shipping-wording text-uppercase" style="display: none;">{{ "Calculando" | translate }}</span>
										<span class="loading ml-1" style="display: none;">
											<svg class="icon-inline icon-spin icon-md ml-2"><use xlink:href="#spinner-third"/></svg>
										</span>
									</button>
								</div>
							</div>
						{% endblock input_append_content %}
						{% block input_form_alert %}
						{% set zipcode_help_countries = ['BR', 'AR', 'MX'] %}
						{% if store.country in zipcode_help_countries %}
							{% set zipcode_help_ar = 'https://www.correoargentino.com.ar/formularios/cpa' %}
							{% set zipcode_help_br = 'http://www.buscacep.correios.com.br/sistemas/buscacep/' %}
							{% set zipcode_help_mx = 'https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/Descarga.aspx' %}
							<a class="btn-link font-small ml-1 mt-2 mb-2 d-inline-block {% if product_detail %} js-shipping-zipcode-help {% endif %}" href="{% if store.country == 'AR' %}{{ zipcode_help_ar }}{% elseif store.country == 'BR' %}{{ zipcode_help_br }}{% elseif store.country == 'MX' %}{{ zipcode_help_mx }}{% endif %}" target="_blank">{{ "No sé mi código postal" | translate }}</a>
						{% endif %}
						<div class="js-ship-calculator-error invalid-zipcode alert alert-danger mt-1" style="display: none;">
							
							{# Specific error message considering if store has multiple languages #}

							{% for language in languages %}
								{% if language.active %}
									{% if languages | length > 1 %}
										{% set wrong_zipcode_wording = ' para ' | translate ~ language.country_name ~ '. Podés intentar con otro o' | translate %}
									{% else %}
										{% set wrong_zipcode_wording = '. ¿Está bien escrito?' | translate %}
									{% endif %}
									{{ "No encontramos este código postal{1}" | translate(wrong_zipcode_wording) }}

									{% if languages | length > 1 %}
										<a href="#" data-toggle="#{% if product_detail %}product{% else %}cart{% endif %}-shipping-country" class="js-modal-open js-open-over-modal btn-link text-lowercase font-small">
											{{ 'cambiar tu país de entrega' | translate }}
										</a>
									{% endif %}
								{% endif %}
							{% endfor %}
						</div>
						<div class="js-ship-calculator-error js-ship-calculator-common-error alert alert-danger" style="display: none;">{{ "Ocurrió un error al calcular el envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
						<div class="js-ship-calculator-error js-ship-calculator-external-error alert alert-danger" style="display: none;">{{ "El calculo falló por un problema con el medio de envío. Por favor intentá de nuevo en unos segundos." | translate }}</div>
						{% endblock input_form_alert %}
						{% block input_add_on %}
							{% if shipping_calculator_variant %}
								<input type="hidden" name="variant_id" id="shipping-variant-id" value="{{ shipping_calculator_variant.id }}">
							{% endif %}
						{% endblock input_add_on %}
					{% endembed %}
				</div>

			</div>

			<div class="js-shipping-calculator-spinner pt-3 pb-4" style="display: none;">
				{% include "snipplets/placeholders/shipping-placeholder.tpl"%}
			</div>
			<div class="js-shipping-calculator-response full-width-container mt-2 {% if product_detail %}list{% endif %}" style="display: none;"></div>	
		</div>
	</div>
</div>
{% endif %}

{# Shipping country modal #}

{% if languages | length > 1 %}

	{% if product_detail %}
		{% set country_modal_id = 'product-shipping-country' %}
	{% else %}
		{% set country_modal_id = 'cart-shipping-country' %}
	{% endif %}

	{% embed "snipplets/modal.tpl" with{modal_id: country_modal_id, modal_class: 'bottom modal-centered-small js-modal-shipping-country', modal_position: 'center', modal_transition: 'slide', modal_header: true, modal_footer: true, modal_width: 'centered', modal_zindex_top: true} %}
		{% block modal_head %}
		    {{ 'País de entrega' | translate }}
		{% endblock %}
		{% block modal_body %}
		    {% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: 'País donde entregaremos tu compra', select_aria_label: 'País donde entregaremos tu compra' | translate, select_custom_class: 'js-shipping-country-select', select_group_custom_class: 'mt-4' } %}
				{% block select_options %}
					{% for language in languages %}
						<option value="{{ language.country }}" data-country-url="{{ language.url }}" {% if language.active %}selected{% endif %}>{{ language.country_name }}</option>
					{% endfor %}
				{% endblock select_options%}
			{% endembed %}
		{% endblock %}
		{% block modal_foot %}
			<a href="#" class="js-save-shipping-country btn btn-primary float-right">{{ 'Aplicar' | translate }}</a>
		{% endblock %}
	{% endembed %}
{% endif %}
