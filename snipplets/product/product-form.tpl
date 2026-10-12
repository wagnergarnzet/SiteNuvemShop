{% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
{% set texts = {'cart': settings.product_button_text ? settings.product_button_text : "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
{% set product_url_with_selected_variant = product.selected_or_first_available_variant ? (product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url %}

{# Breadcrumbs #}

{% if not home_main_product and settings.show_product_header %}
    {% include "snipplets/page-header.tpl" with {product_page: true} %}
{% endif %}

{# Sold products quantity #}

{% set products_sold_limit = settings.quantity_products_sold ? settings.quantity_products_sold : 0 %}
{% if settings.products_sold and (product.sold_qty > products_sold_limit) %}
    <div class="font-small mt-3 mb-2">
        {% if product.sold_qty > 10 %}
            +{{ (product.sold_qty/ 10)|round(0, 'floor') * 10 }}
        {% else %}
            {{ product.sold_qty }}
        {% endif %}
        {{ "vendidos" | translate }}
    </div>
{% endif %}

{# Product name #}

{% if home_main_product %}
    <h2 {% if template == 'product' %}id="product-name"{% endif %} class="js-product-name product-name my-2" data-store="product-name-{{ product.id }}">{{ product.name }}</h2>
{% else %}

    {{ component('nubesdk-slot', { type: "before_product_detail_name" }) }}

    <h1 {% if template == 'product' %}id="product-name"{% endif %} class="js-product-name product-name h2 my-2" data-store="product-name-{{ product.id }}">{{ product.name }}</h1>

    {{ component('nubesdk-slot', { type: "after_product_detail_name" }) }}

{% endif %}

{% set show_sku = product.sku and settings.show_sku %}
{% set show_brand = product.brand and settings.product_brand %}
{% if show_sku or show_brand %}
    <div class="product-meta mb-2">
        {% if show_brand %}
            <span class="product-meta-item product-meta-brand {% if show_sku %}mr-2{% endif %}">
                <span class="product-meta-label">{{ "Marca" | translate }}:</span>
                <span class="product-meta-value product-brand">{{ product.brand }}</span>
            </span>
        {% endif %}
        {% if show_sku %}
            <span class="product-meta-item product-meta-sku">
                <span class="product-meta-label">{{ "Código" | translate }}</span>
                <span class="js-product-sku product-meta-value">{{ product.sku }}</span>
            </span>
        {% endif %}
    </div>
{% endif %}

{# Product price #}

{% set is_subscription_only_product = product.isSubscribable() and product.isSubscriptionOnly() %}
{% set show_discount_percentage = settings.product_discount_percentage and product.compare_at_price > product.price and product.display_price %}
{% set preferred_featured_price = settings.product_featured_price | default('price') %}
{% set payment_discount_available = settings.payment_discount_price and product.display_price and product.showMaxPaymentDiscount and product.maxPaymentDiscount.value > 0 %}
{% set product_featured_price = preferred_featured_price == 'offer' and payment_discount_available ? 'offer' : 'price' %}
{% if show_discount_percentage %}
    {% set discount_rate_percentage = ((product.compare_at_price) - (product.price)) * 100 / (product.compare_at_price) %}
{% endif %}

{{ component('nubesdk-slot', { type: "before_product_detail_price" }) }}

{% if not is_subscription_only_product %}
{% set compare_price_display %}
    <div id="compare_price_display" class="js-compare-price-display price-compare h3{% if not settings.product_discount_percentage %} mb-2{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:{% if settings.product_discount_percentage %}block{% else %}inline-block{% endif %};"{% endif %}>
        {% if product.compare_at_price and product.display_price %}
            {{ product.compare_at_price | money }}
        {% endif %}
    </div>
{% endset %}
{% set price_display %}
    <div class="js-price-display product-price text-brand" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">
        {% if product.display_price %}
            {{ product.price | money }}
        {% endif %}
    </div>
{% endset %}
<div class="js-price-container price-container product-price-container product-price-highlight-{{ product_featured_price }} mb-3" data-store="product-price-{{ product.id }}">
    {% if settings.product_discount_percentage %}
        {{ compare_price_display }}
        <div class="d-flex align-items-center">
            {{ price_display }}
            <span class="font-family-body font-big text-accent ml-2" {% if not show_discount_percentage %}style="display:none;"{% endif %}>
                <span class="js-offer-percentage">{{ discount_rate_percentage | round }}</span>% OFF
            </span>
        </div>
    {% else %}
        {{ compare_price_display }}
        <span class="d-inline-block">
            {{ price_display }}
        </span>
    {% endif %}
    {% if settings.product_unity_price %}
        {% include 'snipplets/unity-price.tpl' %}
    {% endif %}
    {{ component('price-discount-disclaimer', {
        container_classes: 'font-small opacity-60 mt-2 mb-1',
    }) }}
    {{ component('payment-discount-price', {
            visibility_condition: settings.payment_discount_price,
            location: 'product',
            container_classes: "h5 font-weight-bold product-payment-discount-price",
        }) 
    }}
</div>
{% endif %}

{% if product.display_price %}

        {{ component('subscriptions/subscription-price', {
            location: is_subscription_only_product ? 'product_detail' : '',
            subscription_classes: {
                container: 'mb-3',
                prices_container: 'mb-1',
                price_compare: 'h3 price-compare mb-2',
                price_with_subscription: 'product-price text-brand mb-0',
                price_info: 'font-smallest',
                discount_container: 'h6 text-accent mb-1',
                price_without_taxes_container: 'mb-2 font-small opacity-60',
            },
        }) }}

    {{ component('nubesdk-slot', { type: "before_product_detail_payment_options" }) }}

    {% set installments_info = product.installments_info_from_any_variant %}
    {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
    {% set show_payments_info = product.show_installments and product.display_price and installments_info %}

    {% if not home_main_product and (show_payments_info or hasDiscount) %}
        <div {% if installments_info %}data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments"{% endif %} class="{% if installments_info %}js-modal-open js-fullscreen-modal-open{% endif %} js-product-payments-container mb-3 {% if not home_main_product %}col-md-8{% endif %} px-0" {% if not product.display_price or not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
            <div class="row no-gutters">
    {% else %}
        <div class="row no-gutters">
    {% endif %}
        {% if show_payments_info or hasDiscount %}
            <div class="col-12 {% if settings.installments_bold %}installments-bold{% endif %}">
                {% if show_payments_info %}
                    {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "mb-2 font-small"}}) }}
                {% endif %}

                {# Max Payment Discount #}

                {% set hideDiscountContainer = not (hasDiscount and product.showMaxPaymentDiscount) %}
                {% set hideDiscountDisclaimer = not product.showMaxPaymentDiscountNotCombinableDisclaimer %}

                <div class="js-product-discount-container mb-2" {% if hideDiscountContainer %}style="display: none;"{% endif %}>
                    <span><strong class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</strong> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}</span>
                    <div class="js-product-discount-disclaimer font-small mt-1" {% if hideDiscountDisclaimer %}style="display: none;"{% endif %}>
                        {{ (product.showMaxPaymentDiscountCombinesWithSomeDiscounts
                            ? "No acumulable con algunas promociones"
                            : "No acumulable con otras promociones")
                        | translate }}
                    </div>
                </div>

            </div>
        {% endif %}
    {% if not home_main_product and (show_payments_info or hasDiscount) %}
                <div class="col-12">
                    <a id="btn-installments" class="font-small mb-2" href="#" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                        <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#credit-card"/></svg>
                        {{ "Ver más detalles" | translate }}
                    </a>
                </div>
            </div>
        </div>
    {% else %}
        </div>
    {% endif %}

    {{ component('nubesdk-slot', { type: "after_product_detail_payment_options" }) }}

{% endif %}

{{ component('nubesdk-slot', { type: "after_product_detail_price" }) }}

{# Promotional text #}

{{ component('promotions-details', {
    promotions_details_classes: {
        container: 'js-product-promo-container product-promo-container',
        promotion_title: 'h4 font-weight-bold text-accent mb-3',
        valid_scopes: 'font-small mb-0',
        categories_combinable: 'font-small mb-0',
        not_combinable: 'font-small opacity-60 mb-0',
        progressive_discounts_table: 'table mb-2 mt-3',
        progressive_discounts_hidden_table: 'table-body-inverted',
        progressive_discounts_show_more_link: 'btn-link btn-link-primary mb-4',
        progressive_discounts_show_more_icon: 'icon-inline',
        progressive_discounts_hide_icon: 'icon-inline icon-flip-vertical',
        progressive_discounts_promotion_quantity: 'font-weight-light text-lowercase'
    },
    accordion_show_svg_id: 'chevron-down',
    accordion_hide_svg_id: 'chevron-up',
}) }}

{# Product form, includes: Variants, CTA and Shipping calculator #}

<form id="product_form" class="js-product-form product-form" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
	<input type="hidden" name="add_to_cart" value="{{product.id}}" />

    {# Fixed add to cart on scroll #}

    {% if settings.fixed_product_form %}
        <div class="hidden js-fixed-product-form-placeholder js-fixed-product-form">
            <div class="container">
                <div class="row no-gutters d-flex flex-row align-items-center">
                    <div class="col">
                        <div class="row no-gutters d-flex flex-row align-items-center">
                            {% if product.images_count > 0 %}
                            <div class="d-none d-md-block col-auto fixed-product-image pr-3">
                                {% for image in product.images[:1] %}
                                    <div class="image-wrapper position-relative">
                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src='{{  image | product_image_url('small') }}' data-sizes="auto" class="lazyautosizes lazyload" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                                    </div>
                                {% endfor %}
                            </div>
                            {% endif %}
                            <div class="col-12 col-md">
                                <div class="product-name-fixed">{{ product.name }}</div>
                            </div>
                            <div class="col-12 col-md-3 mt-1 mt-md-0 price-container text-md-center" data-store="product-price-{{ product.id }}">
                                <div class="row no-gutters">
                                    <div class="col-12">
                                        <div class="row no-gutters">
                                            {% if product.compare_at_price != product.price %}
                                                <div class="col-auto col-md-12 pr-1" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                                                    <div id="compare_price_display" class="js-compare-price-display h6 price-compare price-compare-fixed {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-1{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %}>{% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}</div>
                                                </div>
                                            {% endif %}
                                            <div class="col">
                                                <div class="js-price-display price-display-fixed mb-0 font-weight-bold {% if product_can_show_installments or (product.promotional_offer and not product.promotional_offer.script.is_percentage_off) %}mb-1{% endif %}" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %}>{% if product.display_price %}{{ product.price | money }}{% endif %}</div>
                                            </div>
                                        </div>
                                    </div>
                                    {% if show_payments_info %}
                                        {{ component('installments', {'location' : 'product_detail', container_classes: { installment: "col-12 font-smallest"}}) }}
                                    {% endif %}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-5 col-md-3">
                        {% if product.variations %}
                        <a class="js-scroll-to-form btn btn-big btn-primary btn-add-to-cart {% if settings.add_button_invert %}add-button-invert{% endif %} w-100 {{ state }}" {% if not product.available or not product.display_price %}disabled{% endif %}>
                            {{ texts[state] | translate }}
                        </a>
                        {% else %}
                            {# Add to cart CTA #}
                            <input type="submit" class="js-addtocart {% if product.available and (settings.show_product_terms and settings.product_terms_tag) and has_terms %}js-addtocart-terms{% endif %} js-prod-submit-form btn btn-big btn-primary btn-add-to-cart {% if settings.add_button_invert %}add-button-invert{% endif %} w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart" />

                            {# Fake add to cart CTA visible during add to cart event #}
                            {% include 'snipplets/placeholders/button-placeholder.tpl' with {'product_detail': true, custom_class: "btn-big"} %}
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    {% endif %}

 	{% if product.variations %}
        {% include "snipplets/product/product-variants.tpl" with {show_size_guide: true} %}
    {% endif %}

    {{ component('kit-products', {
        kit_products_classes: {
            container: 'mb-4',
            list: 'list-unstyled mb-0',
            item_wrap: 'top-line',
            item: 'row no-gutters align-items-center py-2',
            image_wrap: 'col-auto pr-3',
            image: 'kit-products-item-image',
            text: 'col',
            quantity: 'font-small',
            name: 'font-body font-weight-normal mb-0',
        },
    }) }}

    {% if settings.show_custom_fields %}
        {% include "snipplets/product/product-custom-fields.tpl" %}
    {% endif %}

    {% if product.available and settings.show_product_terms %}
		{# Read rule and reference tag from settings #}
		{% set rule = settings.show_terms_rule %}
		{% set ref_tag = settings.product_terms_tag %}

		{# Check if the product has the reference tag #}
		{% set has_ref_tag = false %}
		{% if ref_tag %}
			{% for t in product.tags %}
				{% if t == ref_tag %}
					{% set has_ref_tag = true %}
				{% endif %}
			{% endfor %}
		{% endif %}

		{# Decide whether to show terms based on the selected rule #}
		{% set show_terms = false %}
		{% if rule == 'all' %}
			{% set show_terms = true %}
		{% elseif rule == 'except' %}
			{# Show for all products EXCEPT those with the tag. 
			If no tag is configured, treat as "all". #}
			{% set show_terms = (ref_tag == '' or has_ref_tag == false) %}
		{% elseif rule == 'tag' %}
			{# Show ONLY for products that have the tag. 
			If no tag is configured, show nothing. #}
			{% set show_terms = ref_tag and has_ref_tag %}
		{% endif %}

		{% if show_terms %}
			<div class="divider mt-0"></div>
			<div class="card product-terms mb-3">
				{% if settings.product_terms_title %}
					<div class="card-header h5">{{ settings.product_terms_title }}</div>
				{% endif %}
				{% if settings.product_terms_text %}
					<div class="card-body">
					<p class="mb-0">{{ settings.product_terms_text }}</p>
					</div>
				{% endif %}
				<div class="card-footer">
					<label class="checkbox-container">
					<input class="js-product-terms" type="checkbox" name="product_terms" id="product-terms" autocomplete="off" />
					<span class="checkbox">
						<span class="checkbox-icon"></span>
						<span class="checkbox-text">{{ 'He leído y acepto los términos' | translate }}</span>
					</span>
					</label>
				</div>
			</div>
			<div class="js-product-terms-alert product-terms-alert swing alert-danger" style="display:none">
				{{ 'Debes aceptar los términos para continuar con tu compra.' | translate }}
			</div>
		{% endif %}
	{% endif %}

    <div class="divider mt-0"></div>

    {# Product availability #}
    {% set show_product_quantity = product.available and product.display_price %}

    {{ component('subscriptions/subscription-selector', {
        allow_subscription_only: is_subscription_only_product,
        subscription_only_container: 'overflow-visible',
        subscription_classes: {
            container: 'radio-button-container mb-3',

            radio_button: 'radio-button-item overflow-visible',
            radio_button_label: 'ml-1',
            radio_button_text: 'row',
            radio_button_icon: 'radio-button-icons',
            purchase_option_info_container: 'col-auto font-small pr-0',
            purchase_option_price: 'col text-right font-weight-bold',
            purchase_option_price_info: 'font-smallest',
            purchase_option_single_frequency: 'mt-2 pt-1 font-small opacity-80',
            purchase_option_discount: 'label label-accent label-small ml-1',

            dropdown_container: 'form-group mt-3 mb-0 p-0 background-main ' ~ (not home_main_product ? is_subscription_only_product ? 'col-md-12' : 'col-md-9'),
            dropdown_button: 'form-select form-select-align-left font-small p-2',
            dropdown_icon: 'form-select-icon icon-inline icon-w-14 icon-lg',
            dropdown_options: 'form-select-options',
            dropdown_option: 'form-select-option row no-gutters',
            dropdown_option_info: 'col pr-4',
            dropdown_option_price: 'col-auto text-right font-weight-bold',
            dropdown_option_price_info: 'font-smallest',
            dropdown_option_discount: 'text-accent mt-1 font-weight-bold',
            dropdown_option_frequency_info: 'font-small mt-1',

            shipping_message_icon: 'icon-inline icon-1x svg-icon-text mr-1',
            shipping_message_title: 'font-weight-bold',
            shipping_message_text: 'mt-1 ml-4 pl-2'
        },
        dropdown_icon: true,
        dropdown_icon_svg_id: 'chevron-down',

        shipping_message_icon: true,
        shipping_message_icon_svg_id: 'truck',
    }) }}

    {{ component('nubesdk-slot', { type: "before_product_detail_add_to_cart" }) }}

    <div class="form-row">
        {% set product_quantity_home_product_value = home_main_product ? true : false %}
        {% if show_product_quantity %}
            {% include "snipplets/product/product-quantity.tpl" with {home_main_product: product_quantity_home_product_value} %}
        {% else %}
            <input class="js-quantity-input" type="hidden" value="1">
        {% endif %}
        <div class="{% if product.available and product.display_price %}col-8{% if template == 'product' %} col-md-9{% endif %}{% else %}col-12{% endif %}">

            {# Add to cart CTA #}
            <input type="submit" class="js-addtocart {% if show_terms %}js-addtocart-terms{% endif %} js-prod-submit-form btn btn-big btn-primary btn-add-to-cart {% if settings.add_button_invert %}add-button-invert{% endif %} w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' or show_terms %}disabled aria-disabled="true"{% endif %} data-store="product-buy-button" data-component="product.add-to-cart" />

            {# Fake add to cart CTA visible during add to cart event #}

            {% include 'snipplets/placeholders/button-placeholder.tpl' with {'product_form': true, custom_class: "btn-big"} %}

        </div>
        {% if settings.btn_whatsapp and store.whatsapp and (settings.whatsapp_btn_show == 'all' or (settings.whatsapp_btn_show == 'stock' and product.available) or (settings.whatsapp_btn_show == 'nostock' and not product.available)) %}
            <div class="col-12">
                <a role="button" href="{{ store.whatsapp }}?text={{ ("¡Hola! Me gustaría más información sobre" | translate ~ ": " ~ product.name ~ " - " ~ product_url_with_selected_variant) | url_encode }}" title="WhatsApp" class="js-product-whatsapp-link d-inline-block mt-2 btn btn-whats" target="_blank">
                    <svg class="icon-inline icon-lg mr-1"><use xlink:href="#whatsapp"/></svg>
                    <span class="whats-chat-open">{{ settings.whatsapp_btn_text ? settings.whatsapp_btn_text : "Consúltanos vía WhatsApp" | translate }}</span>
                </a>
            </div>
        {% endif %}
    </div>

    <div class="js-added-to-cart-product-message w-100 mt-3 text-center" style="display: none;">
        <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#check"/></svg>
        <span>{{'Ya agregaste este producto.' | translate }}</span>
        <a href="{% if settings.ajax_cart %}#{% else %}{{ store.cart_url }}{% endif %}" class="{% if settings.ajax_cart %}js-modal-open js-fullscreen-modal-open{% endif %} btn btn-link d-inline-block p-0" {% if settings.ajax_cart %}data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% endif %}>{{ 'Ver carrito' | translate }}</a>
    </div>

    {{ component('nubesdk-slot', { type: "after_product_detail_add_to_cart" }) }}

</form>

    <div class="divider"></div>

    <div class="js-product-detail-bottom product-detail-bottom">

        {# Product description #}
        {% if settings.side_description and product.description is not empty %}
        <div data-store="product-description-{{ product.id }}">    
            <div class="product-description user-content">
                {% if settings.product_description_title %}
                    <h3 class="product-description-title">{{ settings.product_description_title }}</h3>
                {% endif %}
                {{ product.description }}
            </div>
        </div>

        {{ component('nubesdk-slot', { type: "after_product_description" }) }}

        {% endif %}

        {% if template == 'product' %}

            {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

            {{ component('nubesdk-slot', { type: "before_product_detail_shipping_options" }) }}

            {% if show_product_fulfillment %}
                <div class="mb-4 pb-2{% if settings.side_description %} mt-3{% endif %}">
                    {# Shipping calculator and branch link #}

                    <div id="product-shipping-container" class="product-shipping-calculator list" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
                        {% if store.has_shipping %}
                            {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_show': settings.shipping_calculator_product_page and not product.free_shipping, 'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                        {% endif %}
                    </div>

                    {% if store.branches %} 
                        {# Link for branches #}
                        {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
                    {% endif %}
                </div>

            {% endif %}

            {{ component('nubesdk-slot', { type: "after_product_detail_shipping_options" }) }}
        {% endif %}

        {# Product tags #}
        {% include 'snipplets/product/product-tags.tpl' %}

        {# Product informative banners #}

        {% if settings.product_informative_position == 'form' %}
            {% include 'snipplets/product/product-informative-banner.tpl' with { 'banners_position': 'form' } %}
        {% endif %}

        {# Product share #}

        {% if not home_main_product and settings.show_social_share %}
            {% include 'snipplets/social/social-share.tpl' %}
        {% endif %}
    </div>

{% if not home_main_product %}
   {# Product payments details #}
    {% include 'snipplets/product/product-payment-details.tpl' %}
{% endif %}
