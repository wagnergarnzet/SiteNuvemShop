{% if settings.slider_categories and settings.slider_categories is not empty %}
    <section class="section-home section-categories-home position-relative" data-store="home-categories-featured" data-transition="fade-in-up">
        {% if settings.main_categories_title %}
        <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto mb-3 row">
            <div class="col-12 text-center">
                <h2 class="text-heading mb-0">{{ settings.main_categories_title }}</h2>
            </div>
        </div>
        {% endif %}
        <div class="container position-relative px-0 px-md-3">
            <div class="js-swiper-categories swiper">
                <div class="swiper-wrapper">
                    {% for slide in settings.slider_categories %}
                        <div class="swiper-slide">
                            <div class="home-category text-center">
                                {% if slide.link %}
                                    <a href="{{ slide.link | setting_url }}" class="js-home-category" aria-label="{{ 'Categoría' | translate }} {{ loop.index }}">
                                {% endif %}
                                    <div class="home-category-image {% if settings.main_categories_circle %}category-circle{% endif %}">
                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-expand="-10" data-srcset="{{ slide.image | static_url | settings_image_url('large') }} 480w" class="textbanner-image-effect img-fluid d-block w-100 swiper-lazy" alt="{% if slide.link %}{{ category_name }}{% else %}{{ 'Categoría' | translate }} {{ loop.index }}{% endif %}" />
                                        <div class="opacity-fade"></div>
                                    </div>
                                {% if slide.link %}
                                        <div class="home-category-text {% if not settings.main_categories_text_outside %} over-image-center{% endif %}">
                                            {% set category_handle = slide.link | trim('/') | split('/') | last %}
                                            {% include 'snipplets/home/home-categories-name.tpl' %}
                                        </div>
                                    </a>
                                {% endif %}
                            </div>
                        </div>
                    {% endfor %}
                </div>
            </div>
            <div class="js-swiper-categories-prev swiper-button-prev d-none d-md-block svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
                <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
            </div>
            <div class="js-swiper-categories-next swiper-button-next d-none d-md-block svg-icon-text{% if settings.icons_solid %} svg-solid{% endif %}">
                <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
            </div> 
        </div>
        <div class="d-block d-md-none swiper-categories-slide-pagination mt-4"></div>
    </section>
{% endif %}
