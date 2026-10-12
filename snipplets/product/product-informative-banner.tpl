{% set active_banners = 0 %}

{% if settings.product_informative_banner_01_show and (settings.product_informative_banner_01_title or settings.product_informative_banner_01_description) %}
  {% set active_banners = active_banners + 1 %}
{% endif %}

{% if settings.product_informative_banner_02_show and (settings.product_informative_banner_02_title or settings.product_informative_banner_02_description) %}
  {% set active_banners = active_banners + 1 %}
{% endif %}

{% if settings.product_informative_banner_03_show and (settings.product_informative_banner_03_title or settings.product_informative_banner_03_description) %}
  {% set active_banners = active_banners + 1 %}
{% endif %}

{% set show_swiper = active_banners >= 2 and settings.product_informative_carousel_mobile %}

{% set banners_classes = banners_position == 'top' ? 'mt-3 my-md-3' : (banners_position == 'bottom' ? 'mt-3' : '') %}

<div class="product-informative-banner position-relative {{ banners_classes }}">
{% if show_swiper %}
    <div class="js-informative-product swiper">
        <div class="swiper-wrapper {% if banners_position == 'form' %}flex-md-column{% else %}row-md{% endif %}">
{% elseif banners_position != 'form' %}
   <div class="d-md-flex row-md">
{% endif %}
{% for banner in ['product_informative_banner_01', 'product_informative_banner_02', 'product_informative_banner_03'] %}
    {% set product_banner_show = attribute(settings,"#{banner}_show") %}
    {% set product_informative_banner_icon = attribute(settings,"#{banner}_icon") %}
    {% set product_informative_banner_title = attribute(settings,"#{banner}_title") %}
    {% set product_informative_banner_description = attribute(settings,"#{banner}_description") %}
    {% set product_informative_banner_url = attribute(settings,"#{banner}_url") %}
    {% set product_informative_banner_link_text = attribute(settings,"#{banner}_link_text") %}
    {% set has_product_informative_banner = product_banner_show and (product_informative_banner_title or product_informative_banner_description) %}
    {% if has_product_informative_banner %}
        {% set icons = {
            'security': 'security',
            'guarantee': 'guarantee',
            'returns': 'returns',
            'delivery': 'delivery',
            'whatsapp': 'whatsapp',
            'info': 'info',
            'cash': 'barcode',
            'credit': 'credit-card',
            'notification': 'icon-bell',
            'warning': 'warning',
            'box-cancel': 'box-cancel'
        } %}

        {% set icon = icons[product_informative_banner_icon] %}

        <div class="{% if banners_position != 'form' %}col-md {% endif %} {% if show_swiper %}swiper-slide {% if banners_position == 'form' %}mb-4{% else %}mb-0{% endif %}{% else %}mb-4{% endif %}">
        {% if banners_position == 'form' %}
            <div class="position-relative {% if store.branches %}pt-2{% endif %} text-center text-md-left">
        {% else %}
            <div class="mb-md-0 d-flex justify-content-center text-center text-md-left">
        {% endif %}
                <div class="d-flex d-md-none flex-column w-100">
                    {% if product_informative_banner_title or product_informative_banner_icon %}
                        <div class="product-informative-title font-weight-bold d-flex align-items-center justify-content-center d-md-inline-block">
                            {% if icon %}
                                <svg class="icon-inline icon-1x align-text-bottom"><use xlink:href="#{{ icon }}"/></svg>
                            {% endif %}
                            {{ product_informative_banner_title ? product_informative_banner_title }}
                        </div>
                    {% endif %}
                    {% if product_informative_banner_description %}
                        <div>{{ product_informative_banner_description }}</div> 
                    {% endif %}
                </div>
                <div class="d-none d-md-flex form-row">
                    {% if icon %}
                        <div class="col-3 d-flex justify-content-end col-md-auto mb-2 mb-md-0">
                            <svg class="icon-inline icon-1x align-text-bottom"><use xlink:href="#{{ icon }}"/></svg>
                        </div>
                    {% endif %}
                    <div class="{% if not icon %}col-12{% else %}col{% endif %}">
                        {% if product_informative_banner_title %}
                            <div class="mb-1 font-weight-bold">{{ product_informative_banner_title }}</div>
                        {% endif %}
                        {% if product_informative_banner_description %}
                            <div>{{ product_informative_banner_description }}</div> 
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    {% endif %}
{% endfor %}
{% if show_swiper %}
        </div>
    </div>
    <div class="js-informative-product-prev swiper-informative-product-prev swiper-button-prev svg-icon-secondary d-block d-md-none">
        <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
    </div>
    <div class="js-informative-product-next swiper-informative-product-next swiper-button-next svg-icon-secondary d-block d-md-none">
        <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
    </div>
    <div class="services-pagination js-informative-product-pagination swiper-pagination swiper-pagination-black"></div>
{% elseif banners_position != 'form' %}
    </div>
{% endif %}
</div>