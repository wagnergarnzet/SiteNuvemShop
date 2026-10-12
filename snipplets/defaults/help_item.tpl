{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}
{% set item_view_box = '0 0 1000 1000' %}

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

{% set add_button_text = settings.add_button_text ? settings.add_button_text : 'Comprar' | translate %}

<div class="js-item-product{% if slide_item %} js-item-slide swiper-slide{% endif %} {{ columns_mobile_class }} {{ columns_desktop_class }} item-product col-grid" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}">
    <div class="item {% if settings.item_animation %}item-animation{% endif %}{% if not settings.item_borders %} item-borders{% endif %} product-container">

        <div class="labels">
            {% if help_item_2 %}
                <div class="label label-accent">
                    {{ "Envío gratis" | translate }}
                </div>
            {% endif %}
            {% if help_item_1 or help_item_3 or help_item_7 %}
            <div class="label label-accent">
                {% if help_item_1 %}
                    -20% OFF
                {% elseif help_item_3 %}
                    -35% OFF
                {% elseif help_item_7 %}
                    -25% OFF
                {% endif %}
            </div>
            {% endif %}
        </div>

        <div class="item-image {{ item_image_class }}">
            <div style="padding-bottom: {{ item_img_spacing }}%;" class="js-item-image-padding position-relative" data-store="product-item-image-{{ product.id }}">
                <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}">
                    {% if help_item_1 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-1"/></svg>
                    {% elseif help_item_2 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-2"/></svg>
                    {% elseif help_item_3 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-3"/></svg>
                    {% elseif help_item_4 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-4"/></svg>
                    {% elseif help_item_5 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-5"/></svg>
                    {% elseif help_item_6 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-6"/></svg>
                    {% elseif help_item_7 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-7"/></svg>
                    {% elseif help_item_8 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-8"/></svg>
                    {% endif %}
                </a>
            </div>
        </div>

        <div class="item-description text-center">
            <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}" class="item-link">
                <div class="item-name-wrapper">
                    <div class="item-name">{{ "Producto de ejemplo" | translate }}</div>
                </div>
            </a>

            <div class="item-price-container" data-store="product-item-price-{{ product.id }}">
                <div class="item-compare-container">
                    {% if help_item_1 %}
                        {% if store.country == 'BR' %}
                            <span class="js-compare-price-display price-compare {% if columns_mobile == 2 %}price-compare-mobile{% endif %}">
                                {{"120000" | money }}
                            </span>
                            <span class="js-price-display item-price">
                                {{"9600" | money }}
                            </span>
                        {% else %}
                            <span class="js-compare-price-display price-compare {% if columns_mobile == 2 %}price-compare-mobile{% endif %}">
                                {{"96000" | money }}
                            </span>
                            <span class="js-price-display item-price">
                                {{"1200000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_2 %}
                        {% if store.country == 'BR' %}
                            <span class="js-price-display item-price">
                                {{"68000" | money }}
                            </span>
                        {% else %}
                            <span class="js-price-display item-price">
                                {{"680000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_3 %}
                        {% if store.country == 'BR' %}
                            <span class="js-compare-price-display price-compare {% if columns_mobile == 2 %}price-compare-mobile{% endif %}">
                                {{"28000" | money }}
                            </span>
                            <span class="js-price-display item-price">
                                {{"18200" | money }}
                            </span>
                        {% else %}
                            <span class="js-compare-price-display price-compare {% if columns_mobile == 2 %}price-compare-mobile{% endif %}">
                                {{"280000" | money }}
                            </span>
                            <span class="js-price-display item-price">
                                {{"182000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_4 %}
                        {% if store.country == 'BR' %}
                            <span class="js-price-display item-price">
                                {{"32000" | money }}
                            </span>
                        {% else %}
                            <span class="js-price-display item-price">
                                {{"320000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_5 %}
                        {% if store.country == 'BR' %}
                            <span class="js-price-display item-price">
                                {{"24900" | money }}
                            </span>
                        {% else %}
                            <span class="js-price-display item-price">
                                {{"249000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_6 %}
                        {% if store.country == 'BR' %}
                            <span class="js-price-display item-price">
                                {{"42000" | money }}
                            </span>
                        {% else %}
                            <span class="js-price-display item-price">
                                {{"420000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_7 %}
                        {% if store.country == 'BR' %}
                            <span class="js-compare-price-display price-compare {% if columns_mobile == 2 %}price-compare-mobile{% endif %}">
                                {{"46000" | money }}
                            </span>
                            <span class="js-price-display item-price">
                                {{"36800" | money }}
                            </span>
                        {% else %}
                            <span class="js-compare-price-display price-compare {% if columns_mobile == 2 %}price-compare-mobile{% endif %}">
                                {{"460000" | money }}
                            </span>
                            <span class="js-price-display item-price">
                                {{"368000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_8 %}
                        {% if store.country == 'BR' %}
                            <span class="js-price-display item-price">
                                {{"12200" | money }}
                            </span>
                        {% else %}
                            <span class="js-price-display item-price">
                                {{"122000" | money }}
                            </span>
                        {% endif %}
                    {% endif %}
                </div>
            </div>
            <div class="item-actions mt-2">
                <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}" class="btn btn-add-to-cart {% if settings.add_button_invert %}add-button-invert{% endif %} w-100">
                    {% if settings.add_button_icon %}
                        {% include "snipplets/icon-cart.tpl" with {icon_custom_class: "icon-inline svg-icon-background icon-12 mr-2"} %}
                    {% endif %}
                    <span class="js-open-quickshop-wording">{{ add_button_text }}</span>
                </a>
            </div>
        </div>
    </div>
</div>