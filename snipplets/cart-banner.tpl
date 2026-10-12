{% if "cart_banner.png" | has_custom_image %}
    <div class="cart-banner mb-3">
        {% if settings.cart_banner_url %}
            <a href="{{ settings.cart_banner_url }}">
        {% endif %}
            <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ 'cart_banner.png'| static_url | settings_image_url('480w') }}, {{ 'cart_banner.png'| static_url | settings_image_url('640w') }}" class="cart-banner lazyautosizes lazyload fade-in w-100" data-sizes="auto" alt="{{ store.name }}"/>
        {% if settings.cart_banner_url %}
            </a>
        {% endif %}
    </div>
{% endif %}