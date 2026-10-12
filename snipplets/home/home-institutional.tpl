{% set banner_image = "institutional-image.jpg" | has_custom_image %}
{% set banner_title = settings.banner_home_title %}
{% set banner_description = settings.banner_home_description %}
{% set banner_button_text = settings.banner_home_button %}
{% set banner_url = settings.banner_home_url %}
{% set has_banner = banner_title or banner_description or banner_image %}
{% set has_banner_text = banner_title or banner_description or banner_button_text %}
{% if has_banner %}
    {% if settings.institutional_overlay %}
        <section class="{% if not settings.institutional_full_width %}section-home {% else %}institutional-full-width{% endif %} section-institutional text-center" data-store="home-institutional-message">
            {% if not settings.institutional_full_width %}
                <div class="container">
            {% endif %}
                {% if not has_banner_text %}
                    <div class="textbanner textbanner-background textbanner-image-opacity institutional-image-only">
                        {% if banner_image %}
                            <img class="textbanner-image-background lazyautosizes lazyload blur-up" src='{{ 'images/empty-placeholder.png' | static_url }}' data-srcset='{{ "institutional-image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "institutional-image.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "institutional-image.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "institutional-image.jpg" | static_url | settings_image_url('1080p') }} 1920w' data-sizes="auto" data-expand="-10" {% if banner_title %} alt="{{ banner_title }}" {% else %} alt="{{ 'Banner de' | translate }} {{ store.name }}" {% endif %}/>
                        {% endif %}
                    </div>
                {% else %}
                    <div class="textbanner textbanner-background m-0">
                        {% if banner_url %}
                            <a class="textbanner-link" href="{{ settings.banner_home_url }}" {% if banner_title %} title="{{ banner_title }}" aria-label="{{ banner_title }}" {% else %} title="{{ 'Banner de' | translate }} {{ store.name }}" aria-label="{{ 'Banner de' | translate }} {{ store.name }}" {% endif %}>
                            {% endif %}
                            {% if has_banner_text %}
                                <div class="textbanner-image textbanner-image-horizontal-plus {% if banner_image and textoverimage %} overlay textbanner-image-opacity{% endif %}">
                                {% endif %}
                                {% if banner_image %}
                                    <img class="textbanner-image-background lazyautosizes lazyload blur-up" src='{{ 'images/empty-placeholder.png' | static_url }}' data-srcset='{{ "institutional-image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "institutional-image.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "institutional-image.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "institutional-image.jpg" | static_url | settings_image_url('1080p') }} 1920w' data-sizes="auto" data-expand="-10" {% if banner_title %} alt="{{ banner_title }}" {% else %} alt="{{ 'Banner de' | translate }} {{ store.name }}" {% endif %}/>
                                {% endif %}
                                {% if has_banner_text %}
                                </div>
                                <div class="col-md-10 col-lg-8 col-xl-5 textbanner-text{% if textoverimage %} over-image-center{% endif %}">
                                    {% if banner_title %}
                                        <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto {% if banner_description or (banner_url and banner_button_text) %}mb-3{% endif %} row">
                                            <div class="col-12 text-center">
                                                <div class="h2 text-heading mb-0">{{ banner_title }}</div>
                                            </div>
                                        </div>
                                    {% endif %}
                                    {% if banner_description %}
                                        <div class="textbanner-paragraph {% if banner_url and banner_button_text %}mb-3{% endif %}">{{ banner_description }}</div>
                                    {% endif %}
                                    {% if banner_url and banner_button_text %}
                                        <button class="btn btn-default">{{ banner_button_text }}</button>
                                    {% endif %}
                                </div>
                            {% endif %}
                            {% if banner_url %}
                            </a>
                        {% endif %}
                    </div>
                {% endif %}
            {% if not settings.institutional_full_width %}
                </div>
            {% endif %}
        </section>
    {% else %}
        <section class="section-home section-institutional" data-store="home-institutional-message">
            <div class="container{% if settings.institutional_full_width %}-fluid{% endif %}">
                <div class="row">
                    {% if banner_image %}
                    <div class="col-12 col-md-6 {% if not has_banner_text %}offset-md-3{% endif %}">
                        <div class="textbanner-image textbanner-image-horizontal" style="padding-top: 100%;">
                            <img class="textbanner-image-background lazyautosizes lazyload blur-up" src='{{ 'images/empty-placeholder.png' | static_url }}' data-srcset='{{ "institutional-image.jpg" | static_url | settings_image_url('large') }} 480w, {{ "institutional-image.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "institutional-image.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "institutional-image.jpg" | static_url | settings_image_url('1080p') }} 1920w' data-sizes="auto" data-expand="-10" {% if banner_title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                        </div>
                    </div>
                        {% if has_banner_text %}
                        <div class="col-12 col-md-6 d-flex flex-column align-items-center align-items-md-start justify-content-center">
                            <div class="textbanner-text text-center text-md-left">
                                {% if banner_title %}
                                    <div class="section-title {% if settings.section_title_uppercase %}section-title-uppercase{% endif %} mx-auto row no-gutters">
                                        <div class="col-12">
                                            <h3 class="h2 text-heading mb-0 mt-3 mt-md-0">{{ banner_title }}</h3>
                                        </div>
                                    </div>
                                {% endif %}
                                {% if banner_description %}
                                    <div class="textbanner-paragraph mb-3 d-block">{{ banner_description }}</div>
                                {% endif %}
                                {% if banner_url and banner_button_text %}
                                    <a href="{{ banner_url }}" class="btn btn-default d-block d-md-inline-block">{{ banner_button_text }}</a>
                                {% endif %}
                            </div>
                        </div>
                        {% endif %}
                    {% elseif has_banner_text %}
                        <div class="col">
                            <div class="textbanner-text text-center">
                                {% if banner_title %}
                                    <div class="h2 mb-4">{{ banner_title }}</div>
                                {% endif %}
                                {% if banner_description %}
                                    <div class="textbanner-paragraph mb-3 d-block">{{ banner_description }}</div>
                                {% endif %}
                                {% if banner_url and banner_button_text %}
                                    <a href="{{ banner_url }}" class="btn btn-default d-block d-md-inline-block">{{ banner_button_text }}</a>
                                {% endif %}
                            </div>
                        </div>
                    {% endif %}
                </div>
            </div>
        </section>
    {% endif %}
{% endif %}
