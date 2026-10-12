{% if settings.grid_01_show and ( settings.grid_01_title or "grid_01.jpg" | has_custom_image) %}{% set has_banner_01 = true %}{% endif %}
{% if settings.grid_02_show and ( settings.grid_02_title or "grid_02.jpg" | has_custom_image) %}{% set has_banner_02 = true %}{% endif %}
{% if settings.grid_03_show and ( settings.grid_03_title or "grid_03.jpg" | has_custom_image) %}{% set has_banner_03 = true %}{% endif %}
{% if settings.grid_04_show and ( settings.grid_04_title or "grid_04.jpg" | has_custom_image) %}{% set has_banner_04 = true %}{% endif %}

{% if has_banner_01 or has_banner_02 or has_banner_03 or has_banner_04 %}

<section class="section-home section-grid-home" data-store="home-grid-banners">
    <div class="container">

        {% set num_banners = 0 %}
        {% for banner in ['grid_01', 'grid_02', 'grid_03', 'grid_04'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_title = attribute(settings,"#{banner}_title") %}
            {% set banner_button_text = attribute(settings,"#{banner}_button") %}
            {% set has_banner = banner_show and (banner_title or "#{banner}.jpg" | has_custom_image) %}
            {% if has_banner %}
                {% set num_banners = num_banners + 1 %}
            {% endif %}
        {% endfor %}

        <div class="gridbanners" data-layout="{{ num_banners }}">

            {% for banner in ['grid_01', 'grid_02', 'grid_03', 'grid_04'] %}
                {% set banner_show = attribute(settings,"#{banner}_show") %}
                {% set banner_title = attribute(settings,"#{banner}_title") %}
                {% set banner_button_text = attribute(settings,"#{banner}_button") %}
                {% set banner_url = attribute(settings,"#{banner}_url") %}
                {% set has_banner =  banner_show and (banner_title or "#{banner}.jpg" | has_custom_image) %}
                {% set has_banner_text =  banner_title or banner_button_text %}
                {% if has_banner %}

                    <div class="gridbanner banner-{{ loop.index }}">
                        {% if banner_url %}
                            <a class="gridbanner-link" href="{{ banner_url }}"{% if banner_title %} title="{{ banner_title }}" aria-label="{{ banner_title }}"{% else %} title="{{ 'Banner de' | translate }} {{ store.name }}" aria-label="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %}>
                        {% endif %}
                        <div class="gridbanner-image{% if has_banner_text and textoverimage %} overlay{% endif %}">
                            {% if "#{banner}.jpg" | has_custom_image %}
                                <img class="gridbanner-image-background lazyautosizes lazyload blur-up" src='{{ 'images/empty-placeholder.png' | static_url }}' data-srcset='{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "#{banner}.jpg" | static_url | settings_image_url('original') }} 1024w' data-sizes="auto" data-expand="-10" {% if banner_title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                            {% endif %}
                        </div>
                        {% if banner_title or (banner_url and banner_button_text) %}
                            <div class="gridbanner-text{% if textoverimage %} over-image{% endif %}">
                                {% if banner_title %}
                                    <div class="{% if num_banners == 4 and ( loop.index == 3 or loop.index == 4 ) %}h2 mb-2{% else %}h2 h1-md mb-3{% endif %} gridbanner-title {% if banner_url and banner_button_text %}gridbanner-title-with-btn{% endif %}">{{ banner_title }}</div>
                                {% endif %}
                                {% if banner_url and banner_button_text %}
                                    <div class="btn btn-default btn-inline-block gridbanner-btn">{{ banner_button_text }}</div>
                                {% endif %}
                            </div>
                        {% endif %}
                        {% if banner_url %}
                            </a>
                        {% endif %}
                    </div>

                {% endif %}
            {% endfor %}
        </div>
    </div>
</section>

{% endif %}