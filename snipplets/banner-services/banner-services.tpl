{% macro for_each_banner_include(template) %}
    {% set num_banners_services = 0 %}
    {% set available_banners = [] %}
    {% for banner in ['banner_services_01', 'banner_services_02', 'banner_services_03', 'banner_services_04'] %}
        {% set banner_services_icon = attribute(settings,"#{banner}_icon") %}
        {% set banner_services_title = attribute(settings,"#{banner}_title") %}
        {% set banner_services_description = attribute(settings,"#{banner}_description") %}
        {% set banner_services_url = attribute(settings,"#{banner}_url") %}
        {% set has_banner_services =  banner_services_title or banner_services_description %}
        {% if has_banner_services %}
            {% set num_banners_services = num_banners_services + 1 %}
            {% set available_banners = available_banners | merge([banner]) %}
        {% endif %}
    {% endfor %}
    {% for banner in available_banners %}
        {% set banner_services_title = attribute(settings,"#{banner}_title") %}
        {% set banner_services_image = "#{banner}.jpg" | has_custom_image %}
        {% set banner_services_icon = attribute(settings,"#{banner}_icon") %}
        {% set banner_services_description = attribute(settings,"#{banner}_description") %}
        {% set banner_services_url = attribute(settings,"#{banner}_url") %}
        {% include template %}
    {% endfor %}
{% endmacro %}
{% import _self as banner_services %}
{% if settings.banner_services and
      (settings.banner_services_01_title or
      settings.banner_services_01_description or
      settings.banner_services_02_title or
      settings.banner_services_02_description or
      settings.banner_services_03_title or
      settings.banner_services_03_description or
      settings.banner_services_04_title or
      settings.banner_services_04_description)
%}
    <section class="section-home section-informative-banners" data-store="banner-services">
        <div class="{% if settings.banner_services_mobile_format == "slider" %}js-informative-banners swiper{% elseif settings.banner_services_mobile_format == "grid" %}banner-services-grid{% else %}banner-services-block{% endif %} banner-services services-{% if settings.banner_services_mobile == "row" and settings.banner_services_mobile_format != "grid" %}row{% else %}col{% endif %} services-md-{% if settings.banner_services_desktop == "row" %}row{% else %}col{% endif %}">
            <div class="{% if settings.banner_services_mobile_format == "slider" %}swiper-wrapper{% endif %} wrapper">
                {{ banner_services.for_each_banner_include('snipplets/banner-services/banner-services-item.tpl') }}
            </div>
            {% if settings.banner_services_mobile_format == "slider" %}
                <div class="js-informative-banners-prev swiper-button-prev svg-icon-secondary d-flex d-md-none">
                    <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                </div>
                <div class="js-informative-banners-next swiper-button-next svg-icon-secondary d-flex d-md-none">
                    <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
                </div>
                <div class="services-pagination js-informative-banners-pagination swiper-pagination swiper-pagination-black"></div>
            {% endif %}
        </div>
    </section>
{% endif %}