{% set icon_cart_class = 'icon-' ~ settings.icon_cart %}

{% if settings.icon_cart == 'custom' and "icon_cart.png" | has_custom_image and custom_cart_icon %}
    <img class="pr-2 icon-cart-custom" src="{{ "icon_cart.png" | static_url | settings_image_url('large') }}" alt={{ "Ícono del carrito" | translate }} />
{% else %}
    <svg class="{{ icon_custom_class }} {{ icon_cart_class }}"><use xlink:href="#cart"/></svg>
{% endif %}