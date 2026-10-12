{% if settings.product_banner_show and "product-banner.jpg" | has_custom_image and not home_main_product %}
    {% set visibility_classes = mobile ? 'd-block d-md-none mt-3' : 'd-none d-md-block mb-3' %}

    {% set banner_srcset = 'product-banner.jpg' | static_url | settings_image_url('large') ~ ' 480w, ' ~ 'product-banner.jpg' | static_url | settings_image_url('large')  ~ ' 640w' %}
    {% set lazy_classes = not mobile ? 'lazyautosizes lazyload blur-up' %}

    {% set img_src = mobile ? ('product-banner.jpg' | static_url | settings_image_url('large')) : ('images/empty-placeholder.png' | static_url) %}

    {% set attributes = mobile ? ('srcset="' ~ banner_srcset ~ '" sizes="100vw"') : ('data-srcset="' ~ banner_srcset ~ '" data-sizes="auto"') %}

    <div class="col-12 px-md-0 product-banner {{ visibility_classes }}" data-store="product-banner">
        {% if settings.product_banner_url %}
            <a href="{{ settings.product_banner_url }}">
        {% endif %}
            <img class="product-banner position-relative {{ lazy_classes }}" src="{{ img_src }}" {{ attributes | raw }} alt="{{ 'Banner del producto' | translate }}" />
        {% if settings.product_banner_url %}
            </a>
        {% endif %}
    </div>
{% endif %}