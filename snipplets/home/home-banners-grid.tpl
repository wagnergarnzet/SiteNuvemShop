{% set banner = banner | default(false) %}
{% set banner_promotional = banner_promotional | default(false) %}
{% set module = module | default(false) %}

{% if banner %}
    {% set has_banners = settings.banner and settings.banner is not empty %}
    {% set has_mobile_banners = settings.toggle_banner_mobile and settings.banner_mobile and settings.banner_mobile is not empty %}
    {% set section_banner = mobile ? settings.banner_mobile : settings.banner %}
    {% set section_title = settings.banner_title %}
    {% set section_subtitle = settings.banner_subtitle %}
    {% set section_slider = settings.banner_format_mobile == 'slider' or settings.banner_format_desktop == 'slider' %}
    {% set section_slider_both = settings.banner_format_mobile == 'slider' and settings.banner_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.banner_format_mobile == 'slider' and settings.banner_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.banner_format_desktop == 'slider' and settings.banner_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.banner_format_desktop == 'slider' %}
    {% set section_slider_mobile = settings.banner_format_mobile == 'slider' %}
    {% set section_id = mobile ? 'banners-mobile' : 'banners' %}
    {% set section_first = settings.home_order_position_1 == 'categories' %}
    {% set section_columns_desktop_4 = settings.banner_columns_desktop == 4 %}
    {% set section_columns_desktop_3 = settings.banner_columns_desktop == 3 %}
    {% set section_columns_desktop_2 = settings.banner_columns_desktop == 2 %}
    {% set section_columns_desktop_1 = settings.banner_columns_desktop == 1 %}
    {% set section_same_size = settings.banner_same_size %}
    {% set section_align_center = settings.banner_align == 'center' %}
    {% set section_without_margins = settings.banner_without_margins %}
    {% set section_text_outside = settings.banner_text_outside %}
{% endif %}
{% if banner_promotional %}
    {% set has_banners = settings.banner_promotional and settings.banner_promotional is not empty %}
    {% set has_mobile_banners = settings.toggle_banner_promotional_mobile and settings.banner_promotional_mobile and settings.banner_promotional_mobile is not empty %}
    {% set section_banner = mobile ? settings.banner_promotional_mobile : settings.banner_promotional %}
    {% set section_title = settings.banner_promotional_title %}
    {% set section_slider = settings.banner_promotional_format_mobile == 'slider' or settings.banner_promotional_format_desktop == 'slider' %}
    {% set section_slider_both = settings.banner_promotional_format_mobile == 'slider' and settings.banner_promotional_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.banner_promotional_format_mobile == 'slider' and settings.banner_promotional_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.banner_promotional_format_desktop == 'slider' and settings.banner_promotional_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.banner_promotional_format_desktop == 'slider' %}
    {% set section_slider_mobile = settings.banner_promotional_format_mobile == 'slider' %}
    {% set section_id = mobile ? 'banners-promotional-mobile' : 'banners-promotional' %}
    {% set section_first = settings.home_order_position_1 == 'promotional' %}
    {% set section_columns_desktop_4 = settings.banner_promotional_columns_desktop == 4 %}
    {% set section_columns_desktop_3 = settings.banner_promotional_columns_desktop == 3 %}
    {% set section_columns_desktop_2 = settings.banner_promotional_columns_desktop == 2 %}
    {% set section_columns_desktop_1 = settings.banner_promotional_columns_desktop == 1 %}
    {% set section_same_size = settings.banner_promotional_same_size %}
    {% set section_align_center = settings.banner_promotional_align == 'center' %}
    {% set section_without_margins = settings.banner_promotional_without_margins %}
    {% set section_text_outside = settings.banner_promotional_text_outside %}
{% endif %}
{% if module %}
    {% set section_banner = settings.module %}
    {% set section_title = settings.module_title %}
    {% set section_subtitle = settings.module_subtitle %}
    {% set section_slider = settings.module_format_mobile == 'slider' or settings.module_format_desktop == 'slider' %}
    {% set section_slider_both = settings.module_format_mobile == 'slider' and settings.module_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.module_format_mobile == 'slider' and settings.module_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.module_format_desktop == 'slider' and settings.module_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.module_format_desktop == 'slider' %}
    {% set section_slider_mobile = settings.module_format_mobile == 'slider' %}
    {% set section_id = 'modules' %}
    {% set section_columns_desktop_5 = settings.module_columns_desktop == 5 %}
    {% set section_columns_desktop_4 = settings.module_columns_desktop == 4 %}
    {% set section_columns_desktop_3 = settings.module_columns_desktop == 3 %}
    {% set section_columns_desktop_2 = settings.module_columns_desktop == 2 %}
    {% set section_columns_desktop_1 = settings.module_columns_desktop == 1 %}
    {% set two_columns_mobile = settings.module_text_position_mobile == "side" %}
    {% set section_same_size = settings.module_same_size %}
    {% set section_align_center = settings.module_align == "center" %}
    {% set section_text_outside = true %}
    {% set section_first = settings.home_order_position_1 == 'modules' %}
    {% set section_shadow = settings.module_shadow %}
    {% set module_image_classes = section_columns_desktop_1 or section_columns_desktop_2 ? 'col-md-6' : 'col-md-12' %}
    {% set module_text_classes = section_columns_desktop_1 or section_columns_desktop_2 ? 'col-md-6' : 'col-md-12' %}
{% endif %}

{% set visibility_classes = 
    has_banners and has_mobile_banners ? (mobile ? 'd-md-none' : 'd-none d-md-block') 
    : not has_banners and has_mobile_banners and not mobile ? 'd-none' 
%}

{% set banner_classes = section_without_margins ? 'm-0' %}

<div class="js-{{ section_id }}{% if not module %} {{ visibility_classes }}{% endif %}">
    {% if section_title or section_subtitle %}
        <div class="container">
            <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row">
                {% if section_title %}
                <div class="col-12 text-center">
                    <h2 class="text-heading mb-0">{{ section_title }}</h2>
                </div>
                {% endif %}
                {% if section_subtitle %}
                <div class="col-12 text-center mt-2">
                    <p class="home-subtitle text-subtitle">{{ section_subtitle }}</p>
                </div>
                {% endif %}
            </div>
        </div>
    {% endif %}
    <div class="container{% if section_without_margins %}{% if not module %}-fluid{% endif %} overflow-none{% endif %} position-relative {% if section_slider_mobile %}pr-0 pr-md-3{% endif %}">
        {% if section_slider %}
            {% set section_slider_classes = section_slider_both ? 'swiper-products-slider flex-nowrap' : section_slider_mobile_only ? 'swiper-mobile-only flex-nowrap flex-md-wrap' : section_slider_desktop_only ? 'swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0' %}
            <div class="js-swiper-{{ section_id }} swiper">
                <div class="swiper-wrapper {{ section_slider_classes }} {% if not module %}row {% if section_without_margins %}no-gutters{% else %}row-grid{% endif %}{% endif %} {{ section_shadow ? 'py-3' }}">
        {% else %}
            <div class="row">
        {% endif %}

        {% for slide in section_banner %}

            {% set has_banner_text = slide.title or slide.description or slide.button %}

            <div class="js-banner {% if section_slider %}swiper-slide {% endif %}col-grid {% if section_columns_desktop_5 %}col-md-2-4{% elseif section_columns_desktop_4 %}col-md-3{% elseif section_columns_desktop_3 %}col-md-4{% elseif section_columns_desktop_2 %}col-md-6{% elseif section_columns_desktop_1 %}col-md-12{% endif %}">
                <div class="textbanner {{ banner_classes }} {{ section_shadow ? 'p-3' }}">
                    {% if section_shadow %}
                        <div class="shadow-shorter py-4 px-3">
                    {% endif %}
                    {% if slide.link %}
                        <a href="{{ slide.link | setting_url }}" class="textbanner-link" aria-label="{{ 'Carrusel' | translate }} {{ loop.index }}">
                    {% endif %}
                    {% if module %}
                        <div class="row no-gutters align-items-center {{ section_slider_both ? (two_columns_mobile ? 'flex-nowrap' : 'flex-wrap flex-md-nowrap') : section_slider_mobile_only ? (two_columns_mobile ? 'flex-nowrap' : 'flex-wrap') : section_slider_desktop_only ? 'flex-wrap flex-md-nowrap' : two_columns_mobile ? 'flex-nowrap' : 'flex-wrap flex-md-nowrap' }} {{ section_columns_desktop_1 or section_columns_desktop_2 ? 'flex-md-row' : 'flex-md-column' }}{% if not two_columns_mobile %} flex-wrap{% endif %}">
                    {% endif %}
                    <div class="textbanner-image{% if not section_same_size %} p-0{% endif %}{% if module %} {{ two_columns_mobile ? 'col-6' : 'col-12' }} {{ module_image_classes }}{% if section_same_size %} textbanner-image-md{% endif %}{% else %}{% if has_banner_text and not section_text_outside %} overlay{% endif %}{% endif %} overflow-none">

                        {% set apply_lazy_load = 
                            not section_first 
                            or not (
                                loop.first and (
                                    (has_banners and not has_mobile_banners) or 
                                    (has_mobile_banners and mobile) or module
                                )
                            ) 
                        %}

                        {% if apply_lazy_load %}
                            {% set slide_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
                        {% else %}
                            {% set slide_src = slide.image | static_url | settings_image_url('large') %}
                        {% endif %}

                        <img
                            {% if not apply_lazy_load %}fetchpriority="high"{% endif %}
                            {% if slide.width and slide.height %} width="{{ slide.width }}" height="{{ slide.height }}"{% endif %}
                            {% if apply_lazy_load %}data-{% endif %}src="{{ slide_src }}"
                            {% if apply_lazy_load %}
                                data-sizes="auto"
                                data-expand="-10"
                            {% endif %}
                            {% if apply_lazy_load %}data-{% endif %}srcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w"
                            class="js-textbanner-image textbanner-image-effect {% if section_same_size %}textbanner-image-background{% else %}img-fluid d-block w-100{% endif %} zoom-in {% if apply_lazy_load %}lazyautosizes lazyload fade-in{% endif %}"
                            {% if slide.title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %}
                        >
                        {% if apply_lazy_load %}
                            <div class="placeholder-fade placeholder-banner"></div>
                        {% endif %}

                    {% if section_text_outside %}
                        </div>
                    {% endif %}
                    {% if has_banner_text %}
                        <div class="textbanner-text{% if module %} {{ two_columns_mobile ? 'col-6' : 'col-12' }} {{ module_text_classes }} px-3 px-md-0 {{ not section_shadow ? 'mb-3' }} {% if not section_slider_desktop and (section_columns_desktop_1 and loop.index is even) %}order-md-first text-md-right{% endif %}{% endif %}{% if section_align_center %} text-center text-md-center{% endif %} {% if not section_text_outside %} over-image{% endif %} {% if not section_text_outside and slide.color == 'light' %}over-image-invert{% endif %}">
                            {% if slide.title %}
                                <h3 class="{% if section_columns_desktop_4 %}h2-md{% elseif section_columns_desktop_2 %}h3-md{% else %}h1-md{% endif %} mb-2 mt-2 {% if section_columns_desktop_1 and not module %} w-md-50{% endif %} {% if module %}px-md-3{% endif %}">{{ slide.title }}</h3>
                            {% endif %}
                            {% if slide.description %}
                                <div class="textbanner-paragraph {% if not module %}font-small{% endif %} font-md-body{% if slide.button and slide.link %} mb-2{% endif %} {% if section_columns_desktop_1 and not module %} w-md-50{% endif %} {% if module %}pt-1 pb-md-0 px-md-3{% endif %}">{{ slide.description }}</div>
                            {% endif %}
                            {% if slide.button and slide.link %}
                                <div class="btn btn-primary {% if not module %}btn-small{% endif %} mt-1 mt-md-2 {% if module %}mx-md-3{% endif %}">{{ slide.button }}</div>
                            {% endif %}
                        </div>
                    {% endif %}
                    {% if not section_text_outside or module %}
                        </div>
                    {% endif %}
                    {% if slide.link %}
                        </a>
                    {% endif %}
                    {% if section_shadow %}
                        </div>
                    {% endif %}
                </div>
            </div>
        {% endfor %}
        {% if section_slider %}
                </div>
            </div>
            {% if section_banner and section_banner is not empty and section_slider_desktop %}
                <div class="js-swiper-{{ section_id }}-prev swiper-button-prev d-none d-md-block svg-icon-text {% if section_without_margins %}swiper-button-opacity{% else %}swiper-button-outside{% endif %}">
                    <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                </div>
                <div class="js-swiper-{{ section_id }}-next swiper-button-next d-none d-md-block svg-icon-text {% if section_without_margins %}swiper-button-opacity{% else %}swiper-button-outside{% endif %}">
                    <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
                </div>
            {% endif %}
            {% if module %}
                <div class="js-swiper-{{ section_id }}-pagination position-relative swiper-pagination swiper-pagination-black w-100"></div>
            {% endif %}
        {% else %}
            </div>
        {% endif %}
    </div>
</div>
