{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}
{% set image_priority_high = image_priority_high | default(false) %}

{% if template == 'home' %}
    {% set columns_desktop = section_columns_desktop %}
    {% set columns_mobile = section_columns_mobile %}
    {% set section_slider = section_slider %}
{% else %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    {% if template == 'product' %}
        {% set section_slider = true %}
    {% endif %}
{% endif %}

{% set columns_mobile_class = columns_mobile == 1 ? 'col-12' : columns_mobile == 2 ? 'col-6' : loop.index % 5 == 1 ? 'col-12' : 'col-6' %}
{% set columns_desktop_class = columns_desktop == 2 ? 'col-md-6' : columns_desktop == 3 ? 'col-md-4' : columns_desktop == 4 ? 'col-md-3' : columns_desktop == 5 ? 'col-md-2-4' : 'col-md-2' %}

{% set image_size = settings.item_image_format_size %}

{% set image_size_class = image_size == 1 ? 'item-image-square' : image_size == 2 ? 'item-image-landscape' : image_size == 3 ? 'item-image-portrait-3-4' : image_size == 4 ? 'item-image-portrait-2-3' %}

{% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
{% set texts = {'cart': "Comprar", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

{% set is_subscription_only = product.isSubscribable() and product.isSubscriptionOnly() %}
{% set add_button_text = is_subscription_only ? ('our_components.subscriptions.subscribe' | tt) : (settings.add_button_text ? settings.add_button_text : 'Comprar' | translate) %}
{% set show_item_add_button_icon = settings.add_button_icon and product.display_price %}
{% set add_to_cart_base_class = 'btn btn-add-to-cart' %}
{% set add_to_cart_invert_class = settings.add_button_invert ? ' add-button-invert' %}
{% set quick_shop_text = 'Compra rápida de' | translate %}
{% set stack_item_quantity = settings.item_quantity and columns_desktop == 6 %}

<div class="js-item-product{% if slide_item %} js-item-slide swiper-slide{% endif %} {{ columns_mobile_class }} {{ columns_desktop_class }} item-product col-grid {% if reduced_item %}item-product-reduced{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">
    <div class="item {% if settings.item_animation %}item-animation{% endif %}{% if not settings.item_borders %} item-borders{% endif %} product-container">
        {% if settings.quick_shop or settings.product_color_variants %}
            <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %} position-relative" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}">
        {% endif %}
        {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

        {% set show_secondary_image = settings.product_hover and product.other_images %}

        {# Set how much viewport space the images will take to load correct image #}

        {% if columns_mobile == 2 %}
            {% set mobile_image_viewport_space = '50' %}
        {% else %}
            {% set mobile_image_viewport_space = '100' %}
        {% endif %}

        {% if columns_desktop == 4 %}
            {% set desktop_image_viewport_space = '25' %}
        {% elseif columns_desktop == 3 %}
            {% set desktop_image_viewport_space = '33' %}
        {% else %}
            {% set desktop_image_viewport_space = '50' %}
        {% endif %}

        {# Item image #}
        {% set image_classes = 'js-item-image lazyautosizes ' ~ (not image_priority_high ? 'lazyload fade-in') ~ ' img-absolute img-absolute-centered' %}
        {% set image_format_class = settings.item_image_format_size ? 'item-image-format-' ~ settings.item_image_format_size : '' %}
        {% set floating_elements %}
            {% include 'snipplets/labels.tpl' %}
        {% endset %}

        {{ component(
            'product-item-image', {
                image_lazy: true,
                image_lazy_js: true,
                image_data_expand: '-10',
                image_secondary_data_sizes: 'auto',
                image_sizes: '(max-width: 768px) ' ~ mobile_image_viewport_space ~ 'vw, (min-width: 769px) ' ~ desktop_image_viewport_space ~ 'vw',
                secondary_image: show_secondary_image,
                slider: false,
                placeholder: true,
                image_priority_high: image_priority_high,
                custom_content: floating_elements,
                product_item_image_classes: {
                    image_container: 'item-image ' ~ item_image_class ~ ' ' ~ image_format_class,
                    image_padding_container: 'js-item-image-padding item-image-padding position-relative',
                    image: image_classes,
                    image_featured: 'item-image-featured',
                    image_secondary: 'item-image-secondary',
                    placeholder: 'placeholder-fade',
                },
            })
        }}

        {% if (settings.quick_shop or settings.product_color_variants) and product.available and product.display_price and product.variations %}

            {# Hidden product form to update item image and variants: Also this is used for quickshop popup #}

            <div class="js-item-variants hidden">
                <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                    <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                    {% if product.variations %}
                        {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                    {% endif %}

                    {# Add to cart CTA #}

                    {% set show_product_quantity = product.available and product.display_price %}

                    <div class="form-row">

                        {% if show_product_quantity %}
                            {% include "snipplets/product/product-quantity.tpl" with {quickshop: true} %}
                        {% endif %}

                        <div class="{% if show_product_quantity %}col-8 pl-md-0{% else %}col-12{% endif %} buy-button-container">

                            <input type="submit" class="js-addtocart js-prod-submit-form {{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} btn-primary btn-big w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                            {# Fake add to cart CTA visible during add to cart event #}

                            {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}
                        </div>
                    </div>
                </form>
            </div>

        {% endif %}
        {% set show_labels = not product.has_stock or product.compare_at_price or product.promotional_offer %}
        <div class="item-description {% if settings.item_text_align == "left" %}text-left{% else %}text-center{% endif %}" data-store="product-item-info-{{ product.id }}">
            {% if settings.item_same_height %}
                <div class="item-name-container">
            {% endif %}
                {% if settings.product_color_variants %}
                    {% include 'snipplets/grid/item-colors.tpl' %}
                {% endif %}

                {{ component('nubesdk-slot', { type: "before_product_grid_item_name" }) }}

                <div class="item-name-wrapper">
                    {% if settings.item_brand and product.brand %}
                        <a href="{{ store.products_url }}?brand={{ product.brand }}" class="item-brand mb-1" data-brand="{{ product.brand }}">{{ product.brand }}</a>
                    {% endif %}
                    <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" class="item-link">
                        <div class="js-item-name item-name" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                    </a>
                </div>

                {{ component('nubesdk-slot', { type: "after_product_grid_item_name" }) }}

                {% if settings.product_size_variants or settings.product_one_size %}
                    {% include 'snipplets/grid/item-sizes.tpl' %}
                {% endif %}
            {% if settings.item_same_height %}
                </div>
            {% endif %}

            {% if product.display_price and (state != 'nostock' or settings.show_nostock_price) %}
                {{ component('nubesdk-slot', { type: "before_product_grid_item_price" }) }}

                {% include 'snipplets/grid/item-prices.tpl' with {is_subscription_only: is_subscription_only} %}

                {{ component('nubesdk-slot', { type: "after_product_grid_item_price" }) }}
            {% endif %}

            {{ component('subscriptions/subscription-message', {
                subscription_classes: {
                    container: 'text-accent font-weight-bold font-small mt-2 px-2',
                },
            }) }}

            {% if product.available and product.display_price and settings.show_add_button %}
                {% if settings.quick_shop %}
                    <div class="item-actions mt-2">
                        {% if product.variations %}
                            {% if settings.show_quickshop_button %}
                                <div class="row no-gutters {% if columns_mobile == 2 %}d-none d-md-flex{% endif %}">
                                    <div class="col align-items-stretch">
                                        <a class="{{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} h-100" href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" >{{ add_button_text }}</a>
                                    </div>
                                    <div class="col-auto align-items-stretch">
                                        {% if product.isSubscribable() %}
                                            <a href="{{ product_url_with_selected_variant }}" class="{{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} h-100" title="{{ quick_shop_text }} {{ product.name }}" aria-label="{{ quick_shop_text }} {{ product.name }}">
                                                {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-text icon-lg"} %}
                                            </a>
                                        {% else %}
                                            <span data-toggle="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" href="#" class="js-quickshop-modal-open js-fullscreen-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open {{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} h-100" title="{{ quick_shop_text }} {{ product.name }}" aria-label="{{ quick_shop_text }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">
                                                {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-text icon-lg"} %}
                                            </span>
                                        {% endif %}
                                    </div>
                                </div>
                                {% if columns_mobile == 2 %}
                                    {% if product.isSubscribable() %}
                                        <a href="{{ product_url_with_selected_variant }}" class="{{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} h-100 d-flex d-md-none" title="{{ quick_shop_text }} {{ product.name }}" aria-label="{{ quick_shop_text }} {{ product.name }}">
                                            {% if show_item_add_button_icon %}
                                                {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-text icon-12 mr-2"} %}
                                            {% endif %}
                                            <span>{{ add_button_text }}</span>
                                        </a>
                                    {% else %}
                                        <span data-toggle="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" href="#" class="js-quickshop-modal-open js-fullscreen-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open {{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} w-100 d-flex d-md-none" title="{{ quick_shop_text }} {{ product.name }}" aria-label="{{ quick_shop_text }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">
                                            {% if show_item_add_button_icon %}
                                                {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-background icon-12 mr-2"} %}
                                            {% endif %}
                                            <span class="js-open-quickshop-wording">{{ add_button_text }}</span>
                                        </span>
                                    {% endif %}
                                {% endif %}
                            {% else %}
                                {% if product.isSubscribable() %}
                                    <a href="{{ product_url_with_selected_variant }}" class="{{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} h-100" title="{{ quick_shop_text }} {{ product.name }}" aria-label="{{ quick_shop_text }} {{ product.name }}">
                                        {% if show_item_add_button_icon %}
                                            {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-text icon-12 mr-2"} %}
                                        {% endif %}
                                        <span>{{ add_button_text }}</span>
                                    </a>
                                {% else %}
                                    {# Open quickshop popup if has variants #}

                                    <span data-toggle="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" href="#" class="js-quickshop-modal-open js-fullscreen-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open {{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} w-100" title="{{ quick_shop_text }} {{ product.name }}" aria-label="{{ quick_shop_text }} {{ product.name }}" data-component="product-list-item.add-to-cart" data-component-value="{{product.id}}">
                                        {% if show_item_add_button_icon %}
                                            {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-background icon-12 mr-2"} %}
                                        {% endif %}
                                        <span class="js-open-quickshop-wording">{{ add_button_text }}</span>
                                    </span>
                                {% endif %}
                            {% endif %}
                        {% else %}
                            {% if settings.show_quickshop_button %}
                                <div class="row no-gutters">
                                    <div class="col align-items-stretch">
                                        <a class="d-block btn btn-add-to-cart {% if settings.add_button_invert %}add-button-invert{% endif %} h-100" href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}" >{{ add_button_text }}</a>
                                    </div>
                                    <div class="col-auto align-items-stretch">
                                        {# If not variants add directly to cart #}
                                        <form class="js-product-form h-100" method="post" action="{{ store.cart_url }}">
                                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />                                   
                                            <div class="item-submit-container">

                                                {# Add to cart CTA #}

                                                <button type="submit" class="js-addtocart js-prod-submit-form btn btn-add-to-cart {% if settings.add_button_invert %}add-button-invert{% endif %} {{ state }} h-100" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}">
                                                    {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-background icon-lg"} %}
                                                </button>
                                                {# Fake add to cart CTA visible during add to cart event #}
                                                {% include 'snipplets/placeholders/button-placeholder.tpl' with {quickshop_button: true} %}
                                            </div>

                                        </form>
                                    </div>
                                </div>
                            {% else %}
                                <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                                    <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                                    <div class="form-row">
                                        {% if settings.item_quantity %}
                                            {% include "snipplets/product/product-quantity.tpl" with {item_quantity: true, stack_item_quantity: stack_item_quantity} %}
                                        {% endif %}
                                        <div class="item-submit-container {% if settings.item_quantity %}col-12 {% if stack_item_quantity %}mt-1{% else %}col-md-7{% endif %}{% else %}col{% endif %}">

                                            {# Add to cart CTA #}

                                            <button type="submit" class="js-addtocart js-prod-submit-form {{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}">
                                                {% set add_button = show_item_add_button_icon ? ' d-md-inline-block' : ' d-md-none' %}
                                                {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-background icon-12 mr-2" ~ add_button} %}
                                                <span>{{ add_button_text }}</span>
                                            </button>
                                            {# Fake add to cart CTA visible during add to cart event #}
                                            
                                            {% set placeholder_params = settings.item_quantity ? {item_quantity: true} : {direct_add: true} %}
                                            {% include 'snipplets/placeholders/button-placeholder.tpl' with placeholder_params %}
                                        </div>
                                    </div>
                                    
                                </form>
                            {% endif %}
                        {% endif %}
                    </div>
                {% else %}
                    <div class="item-actions mt-2">
                        <a href="{{ product_url_with_selected_variant }}" class="{{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} w-100">
                            {% if show_item_add_button_icon %}
                                {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-background icon-12 mr-2"} %}
                            {% endif %}
                            <span class="js-open-quickshop-wording">{{ add_button_text }}</span>
                        </a>
                    </div>
                {% endif %}
            {% elseif settings.show_add_button %}
                <div class="item-actions mt-2">
                    {% if product.display_price %}
                        <a href="{{ product_url_with_selected_variant }}" class="{{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} w-100 {% if state == 'nostock' %}disabled{% endif %}">
                            <span class="js-open-quickshop-wording">{{ texts[state] | translate }}</span>
                        </a>
                    {% else %}
                        <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />                                   
                            <div class="item-submit-container">

                                {# Add to cart CTA #}

                                <button type="submit" class="js-addtocart js-prod-submit-form {{ add_to_cart_base_class }}{{ add_to_cart_invert_class }} w-100 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}">
                                    <span>{{ texts[state] | translate }}</span>
                                </button>
                                {% include 'snipplets/placeholders/button-placeholder.tpl' with {direct_add: true, add_button_text: texts[state] | translate} %}
                            </div>
                            
                            {# Fake add to cart CTA visible during add to cart event #}
                        </form>
                    {% endif %}
                </div>
            {% endif %}
            {% if settings.item_whatsapp_btn and store.whatsapp and (settings.whatsapp_btn_show == 'all' or (settings.whatsapp_btn_show == 'stock' and product.available) or (settings.whatsapp_btn_show == 'nostock' and not product.available)) %}
                <a role="button" href="{{ store.whatsapp }}?text={{ "¡Hola! Me gustaría más información sobre" | translate }}: {{ product.name }} - {{ product.url }}" title="WhatsApp" class="d-flex d-md-inline-block align-items-center justify-content-center mt-2 btn btn-whats" target="_blank">
                    <svg class="icon-inline icon-lg mr-1"><use xlink:href="#whatsapp"/></svg>
                    <span class="whats-chat-open">{% if settings.whatsapp_btn_text %}{{ settings.whatsapp_btn_text }}{% else %}{{ "Consúltanos vía WhatsApp" | translate }}{% endif %}</span>
                </a>
            {% endif %}
        </div>

        {% if settings.show_card_seals and settings.seals_position == 'top-left' %}
            {% include 'snipplets/seals.tpl' %}
        {% endif %}

        {% if settings.quick_shop or settings.product_color_variants %}
            </div>{# This closes the quickshop tag #}
        {% endif %}

        {# Structured data to provide information for Google about the product content #}
        {{ component('structured-data', {'item': true}) }}
    </div>
</div>
