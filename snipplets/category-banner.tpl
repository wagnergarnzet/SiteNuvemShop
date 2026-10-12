{% set image_sizes = ['small', 'large', 'huge', 'original', '1080p'] %}
{% set category_images = [] %}
{% set has_category_images = category.images is not empty %}
{% set has_banner = 'banner-products.jpg' | has_custom_image %}
{% set has_mobile_banner = 'banner-products-mobile.jpg' | has_custom_image %}

{% for size in image_sizes %}
    {% if banner_footer %}
        {% set category_images = category_images|merge({(size):('banner-products-footer.jpg' | static_url | settings_image_url(size))}) %}
    {% else %}
        {% if has_category_images %}
            {# Define images for admin categories #}
            {% set category_images = category_images|merge({(size):(category.images | first | category_image_url(size))}) %}
        {% else %}
            {# Define images for general banner #}
            {% set category_images = category_images|merge({(size):('banner-products.jpg' | static_url | settings_image_url(size))}) %}
        {% endif %}
    {% endif %}
{% endfor %}

{% if banner_footer %}
    {% set has_footer_banner = 'banner-products-footer.jpg' | has_custom_image %}
    {% set has_footer_mobile_banner = 'banner-products-footer-mobile.jpg' | has_custom_image %}
    <section class="category-banner" data-store="category-banner">
        {% if settings.banner_products_footer_url != '' %}
            <a href="{{ settings.banner_products_footer_url }}"{% if settings.banner_products_external %} target="_blank"{% endif %}>
        {% endif %}
        {% if has_footer_mobile_banner %}
            <img class="lazyautosizes lazyload blur-up position-relative w-100 d-md-none" src="{{ category_images['small'] }}" data-srcset="{{ "banner-products-footer-mobile.jpg"| static_url | settings_image_url('480w') }}, {{ "banner-products-footer-mobile.jpg"| static_url | settings_image_url('640w') }}" data-sizes="auto" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
        {% endif %}
        {% if has_footer_banner %}
            <img class="lazyautosizes lazyload blur-up position-relative w-100 {% if has_footer_mobile_banner %}d-none d-md-block{% endif %}" src="{{ category_images['small'] }}" data-srcset="{{ category_images['large'] }} 480w, {{ category_images['huge'] }} 640w, {{ category_images['original'] }} 1024w, {{ category_images['1080p'] }} 1920w" data-sizes="auto" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
        {% endif %}
        {% if settings.banner_products_footer_url != '' %}
            </a>
        {% endif %}
    </section>
{% else %}
    {% set use_banner = has_banner and not has_category_images %}
    {% set use_mobile_banner = has_mobile_banner and not has_category_images %}
    <section class="category-banner mb-3" data-store="category-banner">
        {% if use_banner and settings.banner_products_url != '' %}
            <a href="{{ settings.banner_products_url }}"{% if settings.banner_products_external %} target="_blank"{% endif %}>
        {% endif %}
        {% if use_mobile_banner %}
            <img class="position-relative w-100 d-md-none" fetchpriority="high" src="{{ "banner-products-mobile.jpg"| static_url | settings_image_url('large') }}" srcset="{{ "banner-products-mobile.jpg"| static_url | settings_image_url('large') }} 480w, {{ "banner-products-mobile.jpg"| static_url | settings_image_url('huge') }} 640w" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
        {% endif %}
        {% if has_category_images or use_banner %}
            <img class="position-relative w-100 {% if use_mobile_banner %}d-none d-md-block{% endif %}" fetchpriority="high" src="{{ category_images['large'] }}" srcset="{{ category_images['large'] }} 480w, {{ category_images['huge'] }} 640w, {{ category_images['original'] }} 1024w, {{ category_images['1080p'] }} 1920w" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
        {% endif %}
        {% if use_banner and settings.banner_products_url != '' %}
            </a>
        {% endif %}
    </section>
{% endif %}
