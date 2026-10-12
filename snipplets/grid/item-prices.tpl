{% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 and settings.show_installments %}

{% set item_payment_discount_price %}
    {{ component('payment-discount-price', {
            visibility_condition: settings.payment_discount_price,
            location: 'product',
        })
    }}
{% endset %}

<div class="item-price-container d-flex flex-column" data-store="product-item-price-{{ product.id }}">

    {% if settings.item_unity_price %}
        {% include 'snipplets/unity-price.tpl' %}
    {% endif %}

    {% if is_subscription_only %}
        {# Subscription price for subscription-only products #}
        {{ component('subscriptions/subscription-price', {
            location: 'product_list',
            subscription_classes: {
                container: '',
                prices_container: 'd-flex flex-column',
                price_compare: 'js-compare-price-display price-compare order' ~ (settings.item_featured_price == "price" ? '-0 item-featured-price' : '-1') ~ (columns_mobile == 2 ? ' price-compare-mobile' : ''),
                price_with_subscription: 'js-price-display item-price item-featured-price order-0',
                discount_container: 'order-2 font-small text-accent d-inline-flex ' ~ (settings.item_text_align == "center" ? 'justify-content-center ' : '') ~ 'align-items-center',
            },
        }) }}
    {% else %}
        {# Standard price display #}
        <div class="item-compare-container order{% if settings.item_featured_price == "price" %}-0 item-featured-price{% else %}-1{% endif %}">
            <span class="js-compare-price-display price-compare {% if columns_mobile == 2 %}price-compare-mobile{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                {{ product.compare_at_price | money }}
            </span>
            <span class="js-price-display item-price">
                {{ product.price | money }}
            </span>
        </div>

        {% if settings.payment_discount_price and item_payment_discount_price %}
            <div class="order{% if settings.item_featured_price == "offer" %}-0 item-featured-price{% else %}-2{% endif %} d-inline-flex {% if settings.item_text_align == "center" %}justify-content-center {% endif %}align-items-center">
                {% if settings.payment_discount_price and settings.item_payment_icon %}
                    {% if 'Pix' in item_payment_discount_price %}
                        <svg class="icon-inline svg-icon-text mr-1"><use xlink:href="#pix"/></svg>
                    {% endif %}
                {% endif %}
                {{ item_payment_discount_price }}
            </div>
        {% endif %}
        {% if product_can_show_installments and not reduced_item %}
            <div class="order{% if settings.item_featured_price == "installments" %}-0 item-featured-price{% else %}-3 item-installments d-flex align-items-center {% if settings.item_text_align == "center" %}justify-content-center {% endif %}{% if settings.installments_bold %}installments-bold{% endif %}{% endif %}">
                {% if settings.show_price_icons %}
                    <svg class="icon-inline svg-icon-text mr-1"><use xlink:href="#credit-card"/></svg>
                {% endif %}
                {{ component('installments', {'location' : 'product_item', container_classes: { installment: "d-inline-block"}}) }}
            </div>
        {% endif %}
    {% endif %}
</div>
