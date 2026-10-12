{# Payments details #}

<div id="single-product" class="js-has-new-shipping {% if settings.product_informative_position == 'top' %}pt-md-1 pb-md-4{% else %}py-md-4{% endif %} js-product-detail js-product-container js-shipping-calculator-container {% if product.has_direct_payment_only %}js-product-has-direct-payment{% endif %} product-detail" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="container">
        {% if settings.product_informative_position == 'top' %}
            {% include 'snipplets/product/product-informative-banner.tpl' with { 'banners_position': 'top' } %}
        {% endif %}
        <div class="row pt-md-2">
            <div class="col-12 col-md-7 px-3 px-md-3 mb-3 mb-md-0" data-store="product-image-{{ product.id }}">
                {% if settings.thumbs_position == "side" %}
                    {% include 'snipplets/product/product-image.tpl' with {side_thumbs: true} %}
                {% else %}
                    {% include 'snipplets/product/product-image.tpl' %}
                {% endif %}
            </div>
            <div class="col px-4 product-info" data-store="product-info-{{ product.id }}">
                {% include 'snipplets/product/product-banner.tpl' %}
            	{% include 'snipplets/product/product-form.tpl' %}
            </div>
        </div>
        <div class="row">
            {# Product video #}
            {% if settings.product_video_description %}
                {% include 'snipplets/product/product-video.tpl' with {video_description: true} %}
            {% endif %}
            <div class="col-12">
                <div class="divider"></div>

                {# Product seals #}
                {% include 'snipplets/product/product-seals.tpl' %}

                {% if settings.product_informative_position == 'middle' %}
                    {% include 'snipplets/product/product-informative-banner.tpl' with { 'banners_position': 'middle' } %}
                {% endif %}
                
                {# Product description #}
                {% if not settings.side_description and product.description is not empty %}
                <div class="px-2" data-store="product-description-{{ product.id }}">    
                    <div class="product-description user-content">
                        {% if settings.product_description_title %}
                            <h3 class="product-description-title">{{ settings.product_description_title }}</h3>
                        {% endif %}
                        {{ product.description }}
                    </div>
                </div>
                {% endif %}

            </div>
        </div>
        {% if settings.product_informative_position == 'bottom' %}
           {% include 'snipplets/product/product-informative-banner.tpl' with { 'banners_position': 'bottom' } %}
        {% endif %}
    </div>
</div>

{% if settings.faq_product %}
    {% include 'snipplets/home/home-faq.tpl' %}
{% endif %}

{% if settings.show_testimonials %}
    {% include 'snipplets/home/home-testimonials.tpl' %}
{% endif %}

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}

<div class="container">
    <div id="reviewsapp"></div>
</div>
