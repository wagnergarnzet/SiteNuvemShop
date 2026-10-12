{% set theme_editor = params.preview %}

{% set has_banner = has_banner | default(false) %}
{% set has_mobile_banners = (settings.toggle_banner_mobile and settings.banner_mobile and settings.banner_mobile is not empty) or theme_editor %}

{% set has_banner_promotional = has_banner_promotional | default(false) %}
{% set has_mobile_banners_promotional = (settings.toggle_banner_promotional_mobile and settings.banner_promotional_mobile and settings.banner_promotional_mobile is not empty) or theme_editor %}

{% set has_module = has_module | default(false) %}

{% if has_banner %}
    {% set data_store_name = 'categories' %}
    {% set section_without_margins = settings.banner_without_margins ? 'section-home-color p-0' %}
{% elseif has_banner_promotional %}
    {% set data_store_name = 'promotional' %}
    {% set section_without_margins = settings.banner_promotional_without_margins ? 'section-home-color p-0' %}
{% elseif has_module %}
    {% set section_name = 'module' %}
{% else %}
    {% set data_store_name = 'featured' %}
    {% set section_without_margins = settings.banner_featured_without_margins ? 'section-home-color p-0' %}
{% endif %}

{% if has_banner or has_banner_promotional %}
    <section class="section-home section-banners-home section-banners-{{ data_store_name }} position-relative overflow-none {{ section_without_margins }}" data-store="home-banner-{{ data_store_name }}" data-transition="fade-in-up">
        {% if has_banner %}
            {% include 'snipplets/home/home-banners-grid.tpl' with {'banner': true} %}
            {% if has_mobile_banners %}
                {% include 'snipplets/home/home-banners-grid.tpl' with {'banner': true, mobile: true} %}
            {% endif %}
        {% endif %}
        {% if has_banner_promotional %}
            {% include 'snipplets/home/home-banners-grid.tpl' with {'banner_promotional': true} %}
            {% if has_mobile_banners_promotional %}
                {% include 'snipplets/home/home-banners-grid.tpl' with {'banner_promotional': true, mobile: true} %}
            {% endif %}
        {% endif %}
    </section>
{% endif %}
{% if has_banner_featured and "featured-banner.jpg" | has_custom_image %}
    <section class="section-home section-banners-home section-banners-{{ data_store_name }} position-relative overflow-none" data-store="home-banner-{{ data_store_name }}" data-transition="fade-in-up">
        <div class="container">
            {% if settings.featured_banner_url != '' %}
                <a href="{{ settings.featured_banner_url }}">
            {% endif %}
                {% if "featured-banner-mobile.jpg" | has_custom_image %}
                    <img class="w-100 d-block d-md-none lazyautosizes lazyload blur-up-big" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "featured-banner-mobile.jpg"| static_url | settings_image_url('1080p') }}" data-sizes="auto" alt="{{ 'Banner' | translate }} {{ loop.index }}"/>
                    <img class="w-100 d-none d-md-block lazyautosizes lazyload blur-up-big" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "featured-banner.jpg"| static_url | settings_image_url('1080p') }}" data-sizes="auto" alt="{{ 'Banner' | translate }} {{ loop.index }}"/>
                {% else %}
                    <img class="w-100 d-block lazyautosizes lazyload blur-up-big" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ "featured-banner.jpg"| static_url | settings_image_url('1080p') }}" data-sizes="auto" alt="{{ 'Banner' | translate }} {{ loop.index }}"/>
                {% endif %}
            {% if settings.featured_banner_url != '' %}
                </a>
            {% endif %}
        </div>
    </section>
{% endif %}
{% if has_module %}
    {% include 'snipplets/home/home-banners-grid.tpl' with {'module': true} %}
{% endif %}