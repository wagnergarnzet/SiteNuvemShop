<div class="swiper-slide service-item">
    {% if banner_services_url %}
        <a href="{{ banner_services_url | setting_url }}" class="banner-services-link">
    {% endif %}
        {% if banner_services_icon != 'none' %}
        <div class="service-image">
            {% set banner_services_icon_classes = 'icon-inline service-icon' %}
            {% if banner_services_icon == 'image' and banner_services_image %}
                <img class="service-item-image service-icon lazyload blur-up-big" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w" data-expand="-10" {% if banner_services_title %}alt="{{ banner_services_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
            {% elseif banner_services_icon == 'shipping' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#truck"/></svg>
            {% elseif banner_services_icon == 'cart' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#shopping-cart"/></svg>
            {% elseif banner_services_icon == 'card' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#credit-card"/></svg>
            {% elseif banner_services_icon == 'security' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#security"/></svg>
            {% elseif banner_services_icon == 'returns' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#returns"/></svg>
            {% elseif banner_services_icon == 'whatsapp' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#whatsapp-lines"/></svg>
            {% elseif banner_services_icon == 'promotions' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#tag"/></svg>
            {% elseif banner_services_icon == 'barcode' %}
                <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#barcode"/></svg>
            {% endif %}
        </div>
        {% endif %}
        <div class="service-text {% if not banner_services_description %}d-flex align-items-center{% endif %}">
            <div class="service-title{% if banner_services_description %} mb-1{% endif %} w-100">{{ banner_services_title }}</div>
            {% if banner_services_description %}
                <p class="m-0">{{ banner_services_description }}</p>
            {% endif %}
        </div>
    {% if banner_services_url %}
        </a>
    {% endif %}
</div>